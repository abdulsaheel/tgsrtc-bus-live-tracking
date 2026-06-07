import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:floating/floating.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/config/app_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/map_tiles.dart';
import '../../../data/models/live_data.dart';
import '../../../data/models/trip_detail.dart';
import '../providers/journey_controller.dart';
import '../providers/track_providers.dart';

/// Fullscreen live tracking: route + stops + moving bus on the map, with a
/// slide-up panel for speed / heading / status / driver.
class LiveMapScreen extends ConsumerStatefulWidget {
  const LiveMapScreen({
    super.key,
    required this.vehicleId,
    required this.title,
    this.tripId,
  });

  final int vehicleId;
  final String title;
  final int? tripId;

  @override
  ConsumerState<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends ConsumerState<LiveMapScreen> {
  final _map = MapController();
  final _pipMap = MapController();
  final _floating = Floating();
  LatLng? _lastBus;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) _setupAutoPip();
  }

  /// Auto-enter PiP on Home gesture — only on Android 12+ (API 31). Older
  /// versions (e.g. API 30) don't support auto-enter and throw; there we rely
  /// on the manual minimize button below. Caught so it never crashes.
  Future<void> _setupAutoPip() async {
    try {
      await _floating.enable(const OnLeavePiP(aspectRatio: Rational(3, 4)));
    } catch (_) {/* auto-PiP unsupported on this OS version */}
  }

  /// Manual minimize → enter PiP now. Works on API 26+.
  Future<void> _enterPip() async {
    try {
      await _floating.enable(const ImmediatePiP(aspectRatio: Rational(3, 4)));
    } catch (_) {/* PiP unavailable / disabled in system settings */}
  }

  /// Default zoom — close enough that locality / chowk / road labels show.
  static const _followZoom = 16.0;

  /// While true, the map auto-follows the bus. Turns off when the user pans/
  /// zooms to explore; the recenter button turns it back on.
  bool _following = true;

  void _recenter() {
    final p = _lastBus;
    if (p == null) return;
    setState(() => _following = true);
    // Re-center and turn the map toward the bus's direction of travel.
    final heading = ref.read(sharedLiveProvider(widget.vehicleId)).asData?.value.heading ?? 0;
    _map.moveAndRotate(p, _followZoom, -heading);
  }

  @override
  void dispose() {
    if (Platform.isAndroid) _floating.cancelOnLeavePiP();
    _map.dispose();
    _pipMap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final live = ref.watch(sharedLiveProvider(widget.vehicleId));
    
    // Use the tripId from live data if available (the ground truth), 
    // otherwise fall back to the one passed in (the search result).
    final liveTripId = live.asData?.value.tripId;
    final activeTripId = (liveTripId != null && liveTripId > 0)
        ? liveTripId
        : widget.tripId;

    final trip = activeTripId == null
        ? null
        : ref.watch(tripDetailProvider(activeTripId));

    // Proximity is handled by the foreground service while following.

    final data = live.asData?.value;
    final busPoint =
        data == null ? null : LatLng(data.latitude, data.longitude);

    // Follow the bus when it moves (only while in follow mode).
    if (busPoint != null && busPoint != _lastBus) {
      final first = _lastBus == null;
      _lastBus = busPoint;
      if (_following) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          // Snap to default zoom on first fix; keep current zoom afterwards.
          _map.move(busPoint, first ? _followZoom : _map.camera.zoom);
        });
      }
    }

    final tripData = trip?.asData?.value;

    final fullView = Scaffold(
      body: Stack(
        children: [
          _Map(
            controller: _map,
            initialCenter: busPoint ??
                _firstRoutePoint(tripData) ??
                const LatLng(17.385, 78.4867),
            initialZoom: _followZoom,
            busPoint: busPoint,
            heading: data?.heading ?? 0,
            stale: data == null ||
                data.isStale(AppConfig.gpsStaleThreshold) ||
                data.hasNoData,
            trip: tripData,
            // User panning/zooming turns off auto-follow.
            onUserGesture: () {
              if (_following) setState(() => _following = false);
            },
          ),
          // Back button overlay (+ minimize-to-PiP on Android).
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _CircleButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  if (Platform.isAndroid) ...[
                    const SizedBox(width: 8),
                    _CircleButton(
                      icon: Icons.picture_in_picture_alt,
                      onTap: _enterPip,
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Loading / error overlays for first load.
          if (live.isLoading && data == null)
            const Center(child: CircularProgressIndicator()),
          if (live.hasError && data == null)
            _ErrorOverlay(
              message: '${live.error}',
              onRetry: () =>
                  ref.invalidate(liveVehicleProvider(widget.vehicleId)),
            ),
          // Recenter button — sits just above the collapsed panel.
          if (busPoint != null)
            Positioned(
              right: 16,
              bottom: MediaQuery.of(context).size.height * 0.34,
              child: FloatingActionButton.small(
                heroTag: 'recenter',
                tooltip: 'Recenter on bus',
                onPressed: _recenter,
                child: Icon(_following ? Icons.my_location : Icons.location_searching),
              ),
            ),
          // Slide-up details panel.
          if (data != null)
            _DetailsPanel(title: widget.title, data: data, trip: tripData),
        ],
      ),
    );

    // On Android, render a stripped-down map-only view while in the OS
    // picture-in-picture window; the full screen otherwise.
    if (!Platform.isAndroid) return fullView;

    // Next-stop name for the PiP ribbon (from the trip's stop list).
    String? nextStopName;
    final np = data?.nextPointId;
    if (tripData != null && np != null && np > 0) {
      for (final p in tripData.points) {
        if (p.id == np) {
          nextStopName = p.name;
          break;
        }
      }
    }

    return PiPSwitcher(
      childWhenEnabled: _PipView(
        controller: _pipMap,
        busPoint: busPoint,
        heading: data?.heading ?? 0,
        data: data,
        nextStop: nextStopName,
      ),
      childWhenDisabled: fullView,
    );
  }

  LatLng? _firstRoutePoint(TripDetail? t) {
    if (t == null || t.polylinePoints.isEmpty) return null;
    final p = t.polylinePoints.first;
    return LatLng(p.lat, p.lng);
  }
}

class _Map extends StatefulWidget {
  const _Map({
    required this.controller,
    required this.initialCenter,
    required this.initialZoom,
    required this.busPoint,
    required this.heading,
    required this.stale,
    required this.trip,
    required this.onUserGesture,
  });

  final MapController controller;
  final LatLng initialCenter;
  final double initialZoom;
  final LatLng? busPoint;
  final double heading;
  final bool stale;
  final TripDetail? trip;
  final VoidCallback onUserGesture;

  @override
  State<_Map> createState() => _MapState();
}

class _MapState extends State<_Map> with SingleTickerProviderStateMixin {
  // Glides the bus marker smoothly from its previous fix to the new one each
  // poll, instead of teleporting — the "live animated journey".
  late final AnimationController _glide = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..addListener(() => setState(() {}));
  LatLng? _from;
  LatLng? _to;

  @override
  void initState() {
    super.initState();
    _to = widget.busPoint;
  }

  @override
  void didUpdateWidget(covariant _Map old) {
    super.didUpdateWidget(old);
    final p = widget.busPoint;
    if (p != null && p != _to) {
      _from = _displayBus ?? old.busPoint ?? p;
      _to = p;
      _glide.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _glide.dispose();
    super.dispose();
  }

  static LatLng _lerp(LatLng a, LatLng b, double t) => LatLng(
        a.latitude + (b.latitude - a.latitude) * t,
        a.longitude + (b.longitude - a.longitude) * t,
      );

  /// Current (interpolated) bus position to render.
  LatLng? get _displayBus => (_from != null && _to != null)
      ? _lerp(_from!, _to!, _glide.value)
      : widget.busPoint;

  /// Splits the route at the bus's position: the part already travelled is
  /// muted/grey, the part ahead is the live colour (Google-Maps convention).
  List<Widget> _routeLayers(List<LatLng> route, LatLng? busPoint) {
    if (busPoint == null) {
      return [
        PolylineLayer(polylines: [
          Polyline(points: route, strokeWidth: 5, color: AppColors.secondary),
        ]),
      ];
    }
    // Nearest route vertex to the bus.
    const dist = Distance();
    var idx = 0;
    var best = double.infinity;
    for (var i = 0; i < route.length; i++) {
      final d = dist(route[i], busPoint);
      if (d < best) {
        best = d;
        idx = i;
      }
    }
    final covered = route.sublist(0, idx + 1);
    final ahead = route.sublist(idx);
    return [
      PolylineLayer(polylines: [
        if (covered.length >= 2)
          Polyline(
            points: covered,
            strokeWidth: 5,
            color: AppColors.statusNoData.withValues(alpha: 0.55), // travelled
          ),
        if (ahead.length >= 2)
          Polyline(
            points: ahead,
            strokeWidth: 5,
            color: AppColors.secondary, // ahead
          ),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    final bus = _displayBus;
    final route = [
      for (final p in trip?.polylinePoints ?? const [])
        LatLng(p.lat, p.lng),
    ];

    return FlutterMap(
      mapController: widget.controller,
      options: MapOptions(
        initialCenter: widget.initialCenter,
        initialZoom: widget.initialZoom,
        minZoom: 4,
        maxZoom: 19,
        onPositionChanged: (camera, hasGesture) {
          if (hasGesture) widget.onUserGesture();
        },
      ),
      children: [
        buildBaseTileLayer(context),
        // Split at the SETTLED position (not the per-frame glide) so the O(n)
        // nearest-vertex scan doesn't run 60fps during the animation.
        if (route.length >= 2) ..._routeLayers(route, widget.busPoint),
        MarkerLayer(
          markers: [
            for (final p in trip?.points ?? const [])
              if (p.latitude != null && p.longitude != null)
                Marker(
                  point: LatLng(p.latitude!, p.longitude!),
                  width: 14,
                  height: 14,
                  child: _StopDot(passed: p.isPassed),
                ),
          ],
        ),
        if (bus != null)
          MarkerLayer(
            markers: [
              Marker(
                point: bus,
                width: 64,
                height: 64,
                child: _BusMarker(heading: widget.heading, stale: widget.stale),
              ),
            ],
          ),
        mapAttribution(),
      ],
    );
  }
}

class _StopDot extends StatelessWidget {
  const _StopDot({required this.passed});
  final bool passed;
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          // Passed stops are "done" — muted grey; upcoming stay accent-ringed.
          color: passed ? AppColors.statusNoData : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: passed ? AppColors.statusNoData : AppColors.secondary,
            width: 2.5,
          ),
        ),
      );
}

/// Top-down bus glyph (assets/icon/bus-top.png) whose nose points LEFT; we
/// rotate it to the travel heading. heading is compass degrees (0 = north);
/// the image's forward = west (270°), so screen rotation = heading + 90°.
class _BusMarker extends StatelessWidget {
  const _BusMarker({required this.heading, required this.stale});
  final double heading;
  final bool stale;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: (heading + 90) * math.pi / 180,
      child: Opacity(
        opacity: stale ? 0.5 : 1.0,
        child: Image.asset(
          'assets/icon/bus-top.png',
          width: 58,
          height: 58,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(10), child: Icon(icon)),
      ),
    );
  }
}

class _ErrorOverlay extends StatelessWidget {
  const _ErrorOverlay({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(32),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_outlined, size: 40),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Maps the bus's reported status to a colour / label / icon.
(Color, String, IconData) _busStatus(LiveData d) {
  if (d.hasNoData) {
    return (AppColors.statusNoData, 'No data', Icons.gps_off);
  }
  final s = (d.statusStr ?? '').toLowerCase();
  if (s.contains('run') || (d.speedKph > 3)) {
    return (AppColors.statusRunning, 'Running', Icons.directions_bus);
  }
  if (s.contains('idle')) {
    return (AppColors.statusIdle, 'Idle', Icons.pause_circle_outline);
  }
  if (s.contains('stop') || s.contains('halt')) {
    return (AppColors.statusStopped, 'Stopped', Icons.stop_circle_outlined);
  }
  // Reporting but not moving.
  return (AppColors.statusIdle, d.statusStr ?? 'Idle', Icons.pause_circle_outline);
}

/// Stripped-down map-only view rendered inside the Android OS picture-in-
/// picture window (no app bar, panels, or buttons — those don't fit a tiny
/// floating window). Just the live map + a bottom status ribbon.
class _PipView extends StatelessWidget {
  const _PipView({
    required this.controller,
    required this.busPoint,
    required this.heading,
    required this.data,
    required this.nextStop,
  });

  final MapController controller;
  final LatLng? busPoint;
  final double heading;
  final LiveData? data;
  final String? nextStop;

  @override
  Widget build(BuildContext context) {
    if (busPoint == null) {
      return const ColoredBox(
        color: Color(0xFF0E1216),
        child: Center(
          child: Text('Locating bus…', style: TextStyle(color: Colors.white)),
        ),
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        controller.move(busPoint!, 16);
      } catch (_) {/* not ready */}
    });
    final (color, _, _) = data != null
        ? _busStatus(data!)
        : (AppColors.statusRunning, 'Live', Icons.directions_bus);
    return ColoredBox(
      color: const Color(0xFF0E1216),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: busPoint!,
              initialZoom: 16,
              interactionOptions:
                  const InteractionOptions(flags: InteractiveFlag.none),
            ),
            children: [
              buildBaseTileLayer(context),
              MarkerLayer(markers: [
                Marker(
                  point: busPoint!,
                  width: 40,
                  height: 40,
                  child: _BusMarker(heading: heading, stale: false),
                ),
              ]),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xF20E1216)],
                ),
              ),
              child: Row(
                children: [
                  Container(
                      width: 10,
                      height: 10,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle)),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      nextStop?.isNotEmpty == true ? nextStop! : 'Tracking…',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Draggable slide-up panel with live stats + driver info.
class _DetailsPanel extends ConsumerWidget {
  const _DetailsPanel({required this.title, required this.data, this.trip});
  final String title;
  final LiveData data;
  final TripDetail? trip;

  int? get _activeTripId {
    final liveTripId = data.tripId;
    if (liveTripId != null && liveTripId > 0) return liveTripId;
    return trip?.id;
  }

  /// If another bus is already being tracked, confirm the switch (only one bus
  /// can be tracked at a time). Returns true if it's OK to proceed.
  Future<bool> _confirmSwitch(BuildContext context, WidgetRef ref) async {
    final journey = ref.read(journeyControllerProvider);
    if (!journey.isFollowing || journey.vehicleId == data.id) return true;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Already tracking a bus'),
        content: Text(
          'You\'re currently tracking ${journey.title ?? 'another bus'}. '
          'Only one bus can be tracked at a time.\n\n'
          'Stop that and track this one instead?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep current'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Switch'),
          ),
        ],
      ),
    );
    return ok ?? false;
  }

  Future<void> _toggleFollow(BuildContext context, WidgetRef ref) async {
    final journey = ref.read(journeyControllerProvider);
    if (journey.vehicleId == data.id) {
      await ref.read(journeyControllerProvider.notifier).stopFollowing();
      return;
    }
    if (!await _confirmSwitch(context, ref)) return;
    await ref.read(journeyControllerProvider.notifier).startFollowing(
          vehicleId: data.id,
          tripId: _activeTripId,
          title: title,
        );
  }

  Future<void> _toggleAlarm(BuildContext context, WidgetRef ref) async {
    final journey = ref.read(journeyControllerProvider);
    final following = journey.vehicleId == data.id;
    if (following && journey.targetStopId != null) {
      // Clear the alarm (keep following).
      await ref.read(journeyControllerProvider.notifier).setTargetStop(0);
      return;
    }

    if (trip == null || trip!.points.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stops are still loading for this trip')),
      );
      return;
    }

    // Setting an alarm on a different bus would switch tracking — confirm first.
    if (!following && !await _confirmSwitch(context, ref)) return;
    if (!context.mounted) return;

    // Offer upcoming stops (from the API's next stop, else nearest onward).
    final allStops = trip!.points;
    var startIdx = 0;
    if (data.nextPointId != null && data.nextPointId != 0) {
      final i = allStops.indexWhere((s) => s.id == data.nextPointId);
      if (i != -1) startIdx = i;
    } else {
      final busPos = LatLng(data.latitude, data.longitude);
      const distance = Distance();
      double best = double.infinity;
      for (var i = 0; i < allStops.length; i++) {
        final s = allStops[i];
        if (s.latitude == null) continue;
        final d = distance(busPos, LatLng(s.latitude!, s.longitude!));
        if (d < best) {
          best = d;
          startIdx = i;
        }
      }
    }
    final upcoming = allStops.sublist(startIdx);

    final stop = await showModalBottomSheet<TripPoint>(
      context: context,
      builder: (context) => _StopPicker(stops: upcoming),
    );
    if (stop == null) return;

    // Setting an alarm implies following (so the service runs and can alert).
    if (following) {
      await ref.read(journeyControllerProvider.notifier).setTargetStop(stop.id);
    } else {
      await ref.read(journeyControllerProvider.notifier).startFollowing(
            vehicleId: data.id,
            tripId: _activeTripId,
            title: title,
            targetStopId: stop.id,
          );
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You\'ll be alerted near ${stop.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journey = ref.watch(journeyControllerProvider);
    final isFollowing = journey.vehicleId == data.id;
    final isAlarmSet = isFollowing &&
        journey.targetStopId != null &&
        journey.targetStopId != 0;

    final stale = data.isStale(AppConfig.gpsStaleThreshold);
    final theme = Theme.of(context);

    // Operational status of the bus (Running / Idle / Stopped / No data).
    final (color, label, icon) = _busStatus(data);
    final ts = data.gpsTimestamp;
    final ago = ts == null ? '—' : '${DateTime.now().difference(ts).inSeconds}s ago';
    final freshness = stale ? '$ago · GPS delayed' : 'Updated $ago';

    final stops = trip?.points ?? const [];

    return DraggableScrollableSheet(
      initialChildSize: 0.32,
      minChildSize: 0.16,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12)],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(title,
                        style: theme.textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis),
                  ),
                  _FollowButton(
                    isFollowing: isFollowing,
                    onTap: () => _toggleFollow(context, ref),
                  ),
                  const SizedBox(width: 8),
                  _AlarmButton(
                    isSet: isAlarmSet,
                    triggered: false,
                    onTap: () => _toggleAlarm(context, ref),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(icon, size: 16, color: color),
                      const SizedBox(width: 6),
                      Text(label,
                          style: theme.textTheme.labelLarge
                              ?.copyWith(color: color)),
                    ]),
                  ),
                ],
              ),
              Text(freshness, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16),
              Row(
                children: [
                  _Stat(
                      icon: Icons.speed,
                      value: '${data.speedKph.round()}',
                      unit: 'km/h',
                      label: 'Speed'),
                  _Stat(
                      icon: Icons.explore,
                      value: '${data.heading.round()}',
                      unit: '°',
                      label: 'Heading'),
                  if (trip?.points.isNotEmpty ?? false)
                    _Stat(
                        icon: Icons.signpost_outlined,
                        value: '${trip!.points.length}',
                        unit: '',
                        label: 'Stops'),
                ],
              ),
              if (data.address != null) ...[
                const Divider(height: 28),
                _InfoRow(
                    icon: Icons.place_outlined,
                    label: 'Near',
                    value: data.address!),
              ],
              if (trip?.driverName != null)
                _InfoRow(
                    icon: Icons.person_outline,
                    label: 'Driver',
                    value: trip!.driverName!),
              if (trip?.helpline != null)
                _InfoRow(
                    icon: Icons.support_agent_outlined,
                    label: 'Helpline',
                    value: trip!.helpline!),
              if (stops.isNotEmpty) ...[
                const Divider(height: 28),
                Row(children: [
                  const Icon(Icons.route_outlined, size: 18),
                  const SizedBox(width: 8),
                  Text('Stops', style: theme.textTheme.titleMedium),
                  const Spacer(),
                  Text('${stops.length}', style: theme.textTheme.bodyMedium),
                ]),
                const SizedBox(height: 8),
                for (final p in stops) _StopRow(point: p),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// One stop in the live journey timeline. Shows the SCHEDULED time and, for
/// stops the bus has already passed today, the ACTUAL arrival (entryTime from
/// the live trip detail) — or an ETA for upcoming stops when forecast exists.
class _StopRow extends StatelessWidget {
  const _StopRow({required this.point});
  final TripPoint point;

  static String _hhmm(int? epochSecs) {
    if (epochSecs == null || epochSecs == 0) return '';
    final d = DateTime.fromMillisecondsSinceEpoch(epochSecs * 1000);
    return '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final passed = point.isPassed;
    final scheduled = _hhmm(point.plannedTime);
    final actual = _hhmm(point.entryTime); // today's actual arrival, if passed
    final eta = passed ? '' : _hhmm(point.eta); // forecast for upcoming
    final muted = theme.colorScheme.onSurfaceVariant;

    // Early/late delta vs schedule, when both known.
    String? delta;
    if (passed && (point.entryTime ?? 0) > 0 && (point.plannedTime ?? 0) > 0) {
      final m = ((point.entryTime! - point.plannedTime!) / 60).round();
      if (m.abs() >= 1) delta = m > 0 ? '$m min late' : '${-m} min early';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            passed ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 18,
            color: passed ? AppColors.statusRunning : muted,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(point.name,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: passed ? muted : null),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                if (delta != null)
                  Text(delta,
                      style: theme.textTheme.bodySmall?.copyWith(color: muted)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (actual.isNotEmpty)
                Text('arrived $actual',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.statusRunning,
                        fontWeight: FontWeight.w600))
              else if (eta.isNotEmpty)
                Text('ETA $eta',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600)),
              if (scheduled.isNotEmpty)
                Text('sch $scheduled',
                    style: theme.textTheme.bodySmall?.copyWith(color: muted)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlarmButton extends StatelessWidget {
  const _AlarmButton({
    required this.isSet,
    required this.triggered,
    required this.onTap,
  });

  final bool isSet;
  final bool triggered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = triggered
        ? AppColors.accent
        : isSet
            ? AppColors.primary
            : Theme.of(context).colorScheme.onSurfaceVariant;

    return IconButton.filledTonal(
      onPressed: onTap,
      style: IconButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color.withValues(alpha: 0.12),
      ),
      icon: Icon(triggered
          ? Icons.notifications_active
          : isSet
              ? Icons.notifications_active_outlined
              : Icons.notifications_none),
      tooltip: isSet ? 'Cancel Alarm' : 'Notify me near a stop',
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({required this.isFollowing, required this.onTap});
  final bool isFollowing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isFollowing
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;

    return IconButton.filledTonal(
      onPressed: onTap,
      style: IconButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color.withValues(alpha: 0.12),
      ),
      icon: Icon(isFollowing ? Icons.push_pin : Icons.push_pin_outlined),
      tooltip: isFollowing ? 'Following Bus' : 'Follow this Bus',
    );
  }
}

class _StopPicker extends StatelessWidget {
  const _StopPicker({required this.stops});
  final List<TripPoint> stops;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Notify me near...', style: theme.textTheme.titleMedium),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: stops.length,
            itemBuilder: (context, index) {
              final s = stops[index];
              final hasCoords = s.latitude != null && s.longitude != null;
              return ListTile(
                leading: const Icon(Icons.place_outlined),
                title: Text(s.name),
                subtitle: hasCoords ? null : const Text('No location data'),
                enabled: hasCoords,
                onTap: () => Navigator.pop(context, s),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(
      {required this.icon,
      required this.value,
      required this.unit,
      required this.label});
  final IconData icon;
  final String value;
  final String unit;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(style: theme.textTheme.titleLarge, children: [
              TextSpan(text: value),
              TextSpan(text: ' $unit', style: theme.textTheme.bodyMedium),
            ]),
          ),
          Text(label, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(
      {required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          SizedBox(
              width: 64,
              child: Text(label, style: theme.textTheme.bodyMedium)),
          Expanded(
              child: Text(value, style: theme.textTheme.titleMedium)),
        ],
      ),
    );
  }
}
