import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/stop.dart';

/// Bottom sheet for a tapped nearby stop: details + Walk here + Plan trip.
void showStopSheet(BuildContext context, {required NearbyStop stop}) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) => _StopSheet(stop: stop),
  );
}

class _StopSheet extends StatelessWidget {
  const _StopSheet({required this.stop});
  final NearbyStop stop;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stop.name, style: t.titleLarge),
            if (stop.distance != null) ...[
              const SizedBox(height: 4),
              Text(
                stop.distance! < 1
                    ? '${(stop.distance! * 1000).round()} m away'
                    : '${stop.distance!.toStringAsFixed(1)} km away',
                style: t.bodyMedium,
              ),
            ],
            if (stop.address != null) ...[
              const SizedBox(height: 8),
              Text(stop.address!, style: t.bodyMedium),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () => _walkHere(context),
                    icon: const Icon(Icons.directions_walk),
                    label: const Text('Walk here'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      context.pushNamed('journey',
                          queryParameters: {'from': stop.name});
                    },
                    icon: const Icon(Icons.alt_route),
                    label: const Text('Plan trip'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _walkHere(BuildContext context) async {
    final lat = stop.latitude, lng = stop.longitude;
    if (lat == null || lng == null) return;
    // geo: URI opens the user's default maps app with walking directions.
    final uri = Uri.parse('geo:$lat,$lng?q=$lat,$lng(${Uri.encodeComponent(stop.name)})');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Fallback to Google Maps web.
      await launchUrl(
        Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng'),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
