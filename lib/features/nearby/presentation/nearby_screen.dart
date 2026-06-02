import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/map_tiles.dart';
import '../../../data/models/stop.dart';
import '../providers/nearby_providers.dart';
import 'stop_sheet.dart';

/// Nearby bus stops: map with your location + stop pins, and a distance list.
class NearbyScreen extends ConsumerWidget {
  const NearbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(currentLatLngProvider);
    final stops = ref.watch(nearbyStopsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby stops'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              ref.invalidate(currentPositionProvider);
              ref.invalidate(nearbyStopsProvider);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: AsyncView<List<NearbyStop>>(
          value: stops,
          onRetry: () {
            ref.invalidate(currentPositionProvider);
            ref.invalidate(nearbyStopsProvider);
          },
          isEmpty: (list) => list.isEmpty,
          empty: const _NoLocationHint(),
          data: (list) => Column(
            children: [
              SizedBox(
                height: 280,
                child: _NearbyMap(me: me, stops: list),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final s = list[i];
                    return ListTile(
                      key: ValueKey('${s.id}'),
                      leading: const Icon(Icons.directions_bus_outlined),
                      title: Text(s.name),
                      subtitle: s.address != null
                          ? Text(s.address!,
                              maxLines: 1, overflow: TextOverflow.ellipsis)
                          : null,
                      trailing: Text(_dist(s.distance)),
                      onTap: () => showStopSheet(context, stop: s),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _dist(double? km) {
    if (km == null) return '';
    return km < 1 ? '${(km * 1000).round()} m' : '${km.toStringAsFixed(1)} km';
  }
}

class _NearbyMap extends StatelessWidget {
  const _NearbyMap({required this.me, required this.stops});
  final LatLng? me;
  final List<NearbyStop> stops;

  @override
  Widget build(BuildContext context) {
    final center = me ??
        (stops.isNotEmpty && stops.first.latitude != null
            ? LatLng(stops.first.latitude!, stops.first.longitude!)
            : const LatLng(17.385, 78.4867)); // Hyderabad fallback

    return FlutterMap(
      options: MapOptions(initialCenter: center, initialZoom: 14),
      children: [
        buildBaseTileLayer(context),
        MarkerLayer(
          markers: [
            for (final s in stops)
              if (s.latitude != null && s.longitude != null)
                Marker(
                  point: LatLng(s.latitude!, s.longitude!),
                  width: 36,
                  height: 36,
                  child: const Icon(Icons.location_on,
                      color: AppColors.primary, size: 32),
                ),
            if (me != null)
              Marker(
                point: me!,
                width: 24,
                height: 24,
                child: const _MeDot(),
              ),
          ],
        ),
      ],
    );
  }
}

class _MeDot extends StatelessWidget {
  const _MeDot();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
    );
  }
}

class _NoLocationHint extends ConsumerWidget {
  const _NoLocationHint();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_off_outlined,
                size: 56, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 12),
            Text('No nearby stops', style: t.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Enable location to see bus stops around you.',
              style: t.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                ref.invalidate(currentPositionProvider);
                ref.invalidate(nearbyStopsProvider);
              },
              icon: const Icon(Icons.my_location),
              label: const Text('Use my location'),
            ),
          ],
        ),
      ),
    );
  }
}
