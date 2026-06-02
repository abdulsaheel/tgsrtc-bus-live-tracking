import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/about_dialog.dart';
import '../../../core/widgets/async_view.dart';
import '../../../data/models/bus_service.dart';
import '../../../data/models/city.dart';
import '../../../data/models/service_category.dart';
import '../providers/track_providers.dart';
import 'city_picker.dart';
import 'route_buses_sheet.dart';

/// Home: shows routes for the detected/selected city + category, with search.
class TrackScreen extends ConsumerStatefulWidget {
  const TrackScreen({super.key});

  @override
  ConsumerState<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends ConsumerState<TrackScreen> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    // Kick off one-time city resolution (persisted → detect → prompt).
    final init = ref.watch(cityInitProvider);
    final selected = ref.watch(selectedCityProvider);
    final detecting = ref.watch(cityDetectingProvider);
    final category = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track a bus'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () => showGamyamAbout(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CityHeader(city: selected, detecting: detecting),
            // Resolve flow: while detecting/loading show spinner; if no city
            // resolved, prompt to choose.
            if (selected == null)
              Expanded(
                child: init.isLoading || detecting
                    ? const Center(child: CircularProgressIndicator())
                    : const CityPickerPrompt(),
              )
            else ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: SegmentedButton<ServiceCategory>(
                  segments: const [
                    ButtonSegment(
                      value: ServiceCategory.city,
                      label: Text('City'),
                      icon: Icon(Icons.location_city_outlined),
                    ),
                    ButtonSegment(
                      value: ServiceCategory.district,
                      label: Text('District'),
                      icon: Icon(Icons.map_outlined),
                    ),
                    ButtonSegment(
                      value: ServiceCategory.airport,
                      label: Text('Airport'),
                      icon: Icon(Icons.flight_outlined),
                    ),
                  ],
                  selected: {category},
                  onSelectionChanged: (s) => ref
                      .read(selectedCategoryProvider.notifier)
                      .state = s.first,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search route or service',
                    hintText: 'e.g. 10H, 230A, METRO',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (v) => setState(() => _filter = v.toLowerCase()),
                ),
              ),
              Expanded(child: _RouteList(filter: _filter)),
            ],
          ],
        ),
      ),
    );
  }
}

class _CityHeader extends ConsumerWidget {
  const _CityHeader({required this.city, required this.detecting});
  final City? city;
  final bool detecting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.06),
      child: InkWell(
        onTap: () => showCityPicker(context, ref),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  detecting
                      ? 'Detecting your city…'
                      : (city?.name ?? 'Choose your city'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (detecting)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                const Text('Change'),
            ],
          ),
        ),
      ),
    );
  }
}

class _RouteList extends ConsumerWidget {
  const _RouteList({required this.filter});
  final String filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(cityRoutesProvider);
    return AsyncView<List<BusService>>(
      value: routes,
      onRetry: () => ref.invalidate(cityRoutesProvider),
      isEmpty: (list) => list.isEmpty,
      empty: const _NoRoutesHint(),
      data: (list) {
        final filtered = filter.isEmpty
            ? list
            : list
                .where((s) =>
                    s.name.toLowerCase().contains(filter) ||
                    (s.routeNumber?.toLowerCase().contains(filter) ?? false) ||
                    (s.serviceType?.toLowerCase().contains(filter) ?? false))
                .toList();
        if (filtered.isEmpty) {
          return const Center(child: Text('No routes match your search'));
        }
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (_, i) {
            final s = filtered[i];
            return ListTile(
              key: ValueKey(s.id),
              leading: const Icon(Icons.directions_bus_outlined),
              title: Text(s.routeNumber?.isNotEmpty == true
                  ? '${s.routeNumber}  ·  ${s.name}'
                  : s.name),
              subtitle: Text(s.serviceType ?? '—'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRouteBuses(context, route: s),
            );
          },
        );
      },
    );
  }
}

class _NoRoutesHint extends StatelessWidget {
  const _NoRoutesHint();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.directions_bus_filled_outlined,
                size: 48, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 12),
            Text('No routes in this category', style: t.titleMedium),
            const SizedBox(height: 4),
            Text(
              'This city may not run services in this category. '
              'Try City / District / Airport above.',
              style: t.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
