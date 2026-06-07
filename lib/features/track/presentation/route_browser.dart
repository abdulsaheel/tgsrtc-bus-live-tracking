import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/async_view.dart';
import '../../../data/models/bus_service.dart';
import '../../../data/models/city.dart';
import '../../../data/models/service_category.dart';
import '../providers/track_providers.dart';
import 'city_picker.dart';
import 'route_buses_sheet.dart';

/// Browse + search routes for one [category] (City or Airport) in the selected
/// city. Sets the global category on entry so the route-buses sheet resolves
/// the right operationType. Used by the dedicated City and Airport screens.
class RouteBrowserScreen extends ConsumerStatefulWidget {
  const RouteBrowserScreen({
    super.key,
    required this.category,
    required this.title,
    required this.searchHint,
  });

  final ServiceCategory category;
  final String title;
  final String searchHint;

  @override
  ConsumerState<RouteBrowserScreen> createState() => _RouteBrowserScreenState();
}

class _RouteBrowserScreenState extends ConsumerState<RouteBrowserScreen> {
  String _filter = '';

  @override
  void initState() {
    super.initState();
    // The route list + buses sheet read the global category.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedCategoryProvider.notifier).state = widget.category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final init = ref.watch(cityInitProvider);
    final selected = ref.watch(selectedCityProvider);
    final detecting = ref.watch(cityDetectingProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CityHeader(city: selected, detecting: detecting),
            if (selected == null)
              Expanded(
                child: init.isLoading || detecting
                    ? const Center(child: CircularProgressIndicator())
                    : const CityPickerPrompt(),
              )
            else ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search route or service',
                    hintText: widget.searchHint,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (v) => setState(() => _filter = v.toLowerCase()),
                ),
              ),
              Expanded(child: _RouteList(category: widget.category, filter: _filter)),
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
  const _RouteList({required this.category, required this.filter});
  final ServiceCategory category;
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
            Text('No routes here', style: t.titleMedium),
            const SizedBox(height: 4),
            Text(
              'This city may not run services in this category.',
              style: t.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
