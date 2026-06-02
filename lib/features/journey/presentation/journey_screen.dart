import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/async_view.dart';
import '../../../data/models/stop.dart';
import '../../track/providers/track_providers.dart';
import '../providers/journey_providers.dart';
import 'stop_search_sheet.dart';

/// Plan a trip: pick From + To stage stops → direct buses between them.
class JourneyScreen extends ConsumerStatefulWidget {
  const JourneyScreen({super.key, this.fromSeed});

  /// Optional stop name to pre-select as From (from "Plan trip from here").
  final String? fromSeed;

  @override
  ConsumerState<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends ConsumerState<JourneyScreen> {
  @override
  void initState() {
    super.initState();
    // Try to pre-select From by matching the seed name to a stage stop.
    final seed = widget.fromSeed;
    if (seed != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final stops = await ref.read(cityStopsProvider.future);
        final match = stops
            .where((s) => s.name.toLowerCase().contains(seed.toLowerCase()))
            .firstOrNull;
        if (match != null) ref.read(fromStopProvider.notifier).state = match;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final from = ref.watch(fromStopProvider);
    final to = ref.watch(toStopProvider);
    final result = ref.watch(journeyResultProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Plan a trip')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _StopField(
                    label: 'From',
                    icon: Icons.trip_origin,
                    stop: from,
                    onTap: () => _pick(context, ref, isFrom: true),
                  ),
                  const SizedBox(height: 12),
                  _StopField(
                    label: 'To',
                    icon: Icons.place,
                    stop: to,
                    onTap: () => _pick(context, ref, isFrom: false),
                  ),
                  if (from != null && to != null) ...[
                    const SizedBox(height: 12),
                    // Transfers: hand off to Google Maps (it has the full
                    // transit graph). Backend multi-leg routing is planned.
                    OutlinedButton.icon(
                      onPressed: () => _openGoogleMaps(context, ref, from, to),
                      icon: const Icon(Icons.alt_route),
                      label: const Text('Directions with transfers (Google Maps)'),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(child: _Results(result: result)),
          ],
        ),
      ),
    );
  }

  void _pick(BuildContext context, WidgetRef ref, {required bool isFrom}) {
    showStopSearch(context, onSelected: (stop) {
      (isFrom ? ref.read(fromStopProvider.notifier) : ref.read(toStopProvider.notifier))
          .state = stop;
    });
  }

  Future<void> _openGoogleMaps(
      BuildContext context, WidgetRef ref, Stop from, Stop to) async {
    // Stage stops have no coordinates, so use names + city for disambiguation.
    final cityName = ref.read(selectedCityProvider)?.name ?? '';
    String place(String n) =>
        Uri.encodeComponent('$n, $cityName, Telangana, India');
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=${place(from.name)}'
      '&destination=${place(to.name)}'
      '&travelmode=transit',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _StopField extends StatelessWidget {
  const _StopField({
    required this.label,
    required this.icon,
    required this.stop,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Stop? stop;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: const Icon(Icons.search),
        ),
        child: Text(
          stop?.name ?? 'Choose stop',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: stop == null
                    ? Theme.of(context).hintColor
                    : Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}

/// A single travel option between the two stops, with type/time/stops details.
class _OptionCard extends StatelessWidget {
  const _OptionCard({required this.option});
  final JourneyOption option;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fmt = DateFormat('h:mm a');
    final trip = option.trip;
    final dep = trip.from?.plannedAt;
    final mins = trip.minutes;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _onTap(context),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(trip.serviceName ?? 'Bus',
                      style: theme.textTheme.titleMedium),
                  const SizedBox(width: 8),
                  if (trip.serviceType != null) _TypeBadge(type: trip.serviceType!),
                  const Spacer(),
                  if (option.isLive)
                    const _LiveChip()
                  else if (dep != null)
                    Text(fmt.format(dep), style: theme.textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.trip_origin, size: 14, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  Expanded(child: Text(trip.from?.name ?? '—', maxLines: 1, overflow: TextOverflow.ellipsis)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: SizedBox(height: 14, child: VerticalDivider(width: 2, thickness: 1)),
              ),
              Row(
                children: [
                  const Icon(Icons.place, size: 14, color: AppColors.accent),
                  const SizedBox(width: 8),
                  Expanded(child: Text(trip.to?.name ?? '—', maxLines: 1, overflow: TextOverflow.ellipsis)),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  if (mins != null) _MetaChip(icon: Icons.schedule, label: '~$mins min'),
                  if (trip.totalStops != null)
                    _MetaChip(icon: Icons.signpost_outlined, label: '${trip.totalStops} stops'),
                  if (trip.depot != null)
                    _MetaChip(icon: Icons.warehouse_outlined, label: trip.depot!),
                  _MetaChip(
                    icon: option.isLive ? Icons.my_location : Icons.event_outlined,
                    label: option.isLive ? 'Track live' : 'Scheduled',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    if (option.isLive) {
      context.pushNamed('live', pathParameters: {
        'vehicleId': '${option.liveVehicleId}',
      }, queryParameters: {
        'title': option.trip.serviceName ?? 'Live bus',
        if (option.liveTripId != null) 'tripId': '${option.liveTripId}',
      });
    } else {
      final t = option.trip.from?.plannedAt;
      final when =
          t == null ? '' : ' Next scheduled ${DateFormat('h:mm a').format(t)}.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No live bus on ${option.trip.serviceName ?? 'this route'} right now.$when'),
      ));
    }
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(type.trim(),
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: AppColors.primary)),
    );
  }
}

class _LiveChip extends StatelessWidget {
  const _LiveChip();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.statusRunning.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.gps_fixed, size: 13, color: AppColors.statusRunning),
        const SizedBox(width: 4),
        Text('Live',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: AppColors.statusRunning)),
      ]),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: theme.colorScheme.outline),
        const SizedBox(width: 5),
        Text(label, style: theme.textTheme.bodyMedium),
      ]),
    );
  }
}

class _Results extends ConsumerWidget {
  const _Results({required this.result});
  final AsyncValue<List<JourneyOption>?> result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncView<List<JourneyOption>?>(
      value: result,
      onRetry: () => ref.invalidate(journeyResultProvider),
      isEmpty: (list) => list != null && list.isEmpty,
      empty: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No direct buses run between these two stops.\n'
            'Try nearby major stops — you may need to change buses.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      data: (list) {
        if (list == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('Pick a From and To stop to see buses.',
                  textAlign: TextAlign.center),
            ),
          );
        }
        final liveCount = list.where((o) => o.isLive).length;
        return ListView.separated(
          itemCount: list.length + 1,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, i) {
            if (i == 0) {
              return Text(
                '${list.length} services'
                '${liveCount > 0 ? ' · $liveCount live now' : ''}',
                style: Theme.of(context).textTheme.titleMedium,
              );
            }
            return _OptionCard(option: list[i - 1]);
          },
        );
      },
    );
  }
}
