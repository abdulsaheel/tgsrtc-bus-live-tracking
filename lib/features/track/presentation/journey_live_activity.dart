import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/map_tiles.dart';
import '../providers/journey_controller.dart';

/// Floating picture-in-picture window shown while following a bus (the in-app
/// mirror of the live activity). Like a video-call PiP: a small, draggable,
/// corner-snapping window with a zoomed-in live map of the bus, a live status
/// badge, and a bottom ribbon naming the next stop. Tap to expand to the full
/// live screen. Mounted as a direct child of the app shell's [Stack].
class JourneyLiveActivity extends ConsumerStatefulWidget {
  const JourneyLiveActivity({super.key});

  @override
  ConsumerState<JourneyLiveActivity> createState() =>
      _JourneyLiveActivityState();
}

class _JourneyLiveActivityState extends ConsumerState<JourneyLiveActivity> {
  static const double _w = 168;
  static const double _h = 214;
  static const double _margin = 12;

  final MapController _map = MapController();
  Offset? _pos; // top-left in screen space; null → default (top-right)
  bool _dragging = false;

  @override
  void dispose() {
    _map.dispose();
    super.dispose();
  }

  Offset _defaultPos(Size screen, EdgeInsets pad) =>
      Offset(screen.width - _w - _margin, pad.top + _margin);

  void _snap(Size screen, EdgeInsets pad) {
    final p = _pos ?? _defaultPos(screen, pad);
    final minX = _margin;
    final maxX = screen.width - _w - _margin;
    final minY = pad.top + _margin;
    final maxY = screen.height - _h - pad.bottom - _margin;
    // snap horizontally to the nearer edge; clamp vertically
    final left = (p.dx + _w / 2) < screen.width / 2;
    setState(() {
      _pos = Offset(
        left ? minX : maxX,
        p.dy.clamp(minY, maxY),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final j = ref.watch(journeyControllerProvider);
    if (!j.isFollowing) return const SizedBox.shrink();

    // Keep the mini map centred on the bus as new fixes arrive.
    if (j.hasFix) {
      final c = LatLng(j.lat!, j.lng!);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          _map.move(c, 16);
        } catch (_) {/* map not ready yet */}
      });
    }

    final media = MediaQuery.of(context);
    final screen = media.size;
    final pad = media.padding;
    final pos = _pos ?? _defaultPos(screen, pad);

    return Positioned(
      left: pos.dx,
      top: pos.dy,
      child: GestureDetector(
        onPanStart: (_) => setState(() => _dragging = true),
        onPanUpdate: (d) => setState(() {
          _pos = (_pos ?? _defaultPos(screen, pad)) + d.delta;
        }),
        onPanEnd: (_) {
          _dragging = false;
          _snap(screen, pad);
        },
        onTap: () => context.pushNamed('live', pathParameters: {
          'vehicleId': '${j.vehicleId}',
        }, queryParameters: {
          'title': j.title ?? 'Live bus',
          if (j.tripId != null) 'tripId': '${j.tripId}',
        }),
        child: _PipCard(state: j, map: _map, lifted: _dragging, onClose: () {
          ref.read(journeyControllerProvider.notifier).stopFollowing();
        }),
      ),
    );
  }
}

class _PipCard extends StatelessWidget {
  const _PipCard({
    required this.state,
    required this.map,
    required this.lifted,
    required this.onClose,
  });

  final JourneyState state;
  final MapController map;
  final bool lifted;
  final VoidCallback onClose;

  ({String label, Color color}) get _status {
    final l = (state.statusStr ?? '').toLowerCase();
    if (l.contains('stop')) return (label: 'Stopped', color: AppColors.statusStopped);
    if (l.contains('idle') || l.contains('halt')) {
      return (label: 'Halted', color: AppColors.statusIdle);
    }
    if (l.contains('run') || l.contains('mov') || state.speedKph > 0) {
      return (label: 'Moving', color: AppColors.statusRunning);
    }
    return (label: 'Halted', color: AppColors.statusIdle);
  }

  @override
  Widget build(BuildContext context) {
    final st = _status;
    final center =
        state.hasFix ? LatLng(state.lat!, state.lng!) : const LatLng(17.385, 78.4867);

    return Material(
      elevation: lifted ? 16 : 9,
      borderRadius: BorderRadius.circular(20),
      color: const Color(0xFF0E1216),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: _JourneyLiveActivityState._w,
          height: _JourneyLiveActivityState._h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // --- live map preview ---
              if (state.hasFix)
                FlutterMap(
                  mapController: map,
                  options: MapOptions(
                    initialCenter: center,
                    initialZoom: 16,
                    interactionOptions:
                        const InteractionOptions(flags: InteractiveFlag.none),
                  ),
                  children: [
                    buildBaseTileLayer(context),
                    MarkerLayer(markers: [
                      Marker(
                        point: center,
                        width: 34,
                        height: 34,
                        child: _PipBus(heading: state.heading, color: st.color),
                      ),
                    ]),
                  ],
                )
              else
                const ColoredBox(
                  color: Color(0xFF0E1216),
                  child: Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),

              // --- live status badge (top-left) ---
              Positioned(
                left: 8,
                top: 8,
                child: _StatusBadge(label: st.label, color: st.color, speed: state.speedKph.round()),
              ),

              // --- close (top-right) ---
              Positioned(
                right: 4,
                top: 4,
                child: Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onClose,
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.close, size: 15, color: Colors.white),
                    ),
                  ),
                ),
              ),

              // --- bottom ribbon: next stop ---
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 7, 10, 9),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xF20E1216)],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.nextStop?.isNotEmpty == true
                            ? 'NEXT STOP'
                            : 'TRACKING',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        state.nextStop?.isNotEmpty == true
                            ? state.nextStop!
                            : (state.title ?? 'Live bus'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small bus marker for the PiP map (pulsing ring + heading arrow).
class _PipBus extends StatelessWidget {
  const _PipBus({required this.heading, required this.color});
  final double heading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 8)],
      ),
      child: Transform.rotate(
        angle: heading * math.pi / 180,
        child: const Icon(Icons.navigation, color: Colors.white, size: 16),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color, required this.speed});
  final String label;
  final Color color;
  final int speed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulseDot(color: color),
          const SizedBox(width: 5),
          Text(
            '$label · $speed km/h',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  const _PulseDot({required this.color});
  final Color color;
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.35, end: 1.0).animate(_c),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}
