import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/bus_trip.dart';
import '../../../data/models/planned_trip.dart';
import '../../../data/models/service_category.dart';
import '../../../data/models/stop.dart';
import '../providers/track_providers.dart';
import 'city_picker.dart';

enum SearchMode { between, route, service, bus }

/// Unified multi-mode bus search, shared by the City and District screens.
/// Modes are chosen per [category] (city: between/route/bus, district:
/// between/service/route). Mirrors the official app's per-category search menu.
class BusSearchScreen extends ConsumerStatefulWidget {
  const BusSearchScreen({
    super.key,
    required this.category,
    required this.title,
  });

  final ServiceCategory category;
  final String title;

  @override
  ConsumerState<BusSearchScreen> createState() => _BusSearchScreenState();
}

class _BusSearchScreenState extends ConsumerState<BusSearchScreen> {
  late SearchMode _mode = _modes.first;

  List<SearchMode> get _modes => widget.category == ServiceCategory.district
      ? [SearchMode.between, SearchMode.service, SearchMode.route]
      : [SearchMode.between, SearchMode.route, SearchMode.bus];

  bool get _needsCity => widget.category.cityScoped; // city/airport need a city

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedCategoryProvider.notifier).state = widget.category;
    });
  }

  String _label(SearchMode m) => switch (m) {
        SearchMode.between =>
          widget.category == ServiceCategory.district ? 'Places' : 'Stops',
        SearchMode.route => 'Route no.',
        SearchMode.service => 'Service no.',
        SearchMode.bus => 'Bus no.',
      };

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(selectedCityProvider);
    final detecting = ref.watch(cityDetectingProvider);
    final init = ref.watch(cityInitProvider);

    // City/Airport modes need a selected city first.
    if (_needsCity && selected == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: (init.isLoading || detecting)
            ? const Center(child: CircularProgressIndicator())
            : const CityPickerPrompt(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (_needsCity)
            TextButton.icon(
              onPressed: () => showCityPicker(context, ref),
              icon: const Icon(Icons.location_on_outlined, size: 18),
              label: Text(selected?.name ?? 'City'),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: SegmentedButton<SearchMode>(
                segments: [
                  for (final m in _modes)
                    ButtonSegment(value: m, label: Text(_label(m))),
                ],
                selected: {_mode},
                showSelectedIcon: false,
                onSelectionChanged: (s) => setState(() => _mode = s.first),
              ),
            ),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }

  Widget _body() => switch (_mode) {
        SearchMode.between => _BetweenSearch(category: widget.category),
        SearchMode.route => const _RouteNumberSearch(),
        SearchMode.bus => const _BusNumberSearch(),
        SearchMode.service => const _ServiceNumberSearch(),
      };
}

// ─────────────────────────── shared: track a trip ───────────────────────────

void _track(BuildContext context, {required int vehicleId, String? title, int? tripId}) {
  context.pushNamed('live', pathParameters: {
    'vehicleId': '$vehicleId',
  }, queryParameters: {
    'title': title ?? 'Live bus',
    if (tripId != null && tripId > 0) 'tripId': '$tripId',
  });
}

String _hhmm(DateTime? d) => d == null
    ? ''
    : '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

/// Tappable list of running buses → live tracking.
class _TripTile extends StatelessWidget {
  const _TripTile(this.bus);
  final BusTrip bus;
  @override
  Widget build(BuildContext context) {
    final dep = _hhmm(bus.from?.plannedAt);
    final live = bus.vehicleId != null;
    final route = (bus.from?.name != null && bus.to?.name != null)
        ? '${bus.from!.name} → ${bus.to!.name}'
        : null;
    return ListTile(
      isThreeLine: route != null,
      leading: Icon(Icons.directions_bus,
          color: live ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant),
      title: Text([
        bus.serviceName ?? bus.vehicleNumber ?? 'Bus',
        if (bus.serviceType != null) '· ${bus.serviceType}',
      ].join(' ')),
      subtitle: Text([
        ?route,
        [
          if (bus.vehicleNumber != null) bus.vehicleNumber,
          if (dep.isNotEmpty) 'Dep $dep',
          if (bus.travelMinutes != null) '${bus.travelMinutes} min',
        ].whereType<String>().join('  ·  '),
      ].join('\n')),
      trailing: live ? const Icon(Icons.my_location, size: 20) : null,
      onTap: live
          ? () => _track(context,
              vehicleId: bus.vehicleId!,
              title: bus.vehicleNumber ?? bus.serviceName ?? 'Live bus',
              tripId: bus.id)
          : null,
    );
  }
}

class _AsyncTrips extends StatelessWidget {
  const _AsyncTrips({required this.value, required this.onRetry, this.emptyText = 'No buses found.'});
  final AsyncValue<List<BusTrip>> value;
  final VoidCallback onRetry;
  final String emptyText;
  @override
  Widget build(BuildContext context) => value.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorRetry('$e', onRetry),
        data: (list) => list.isEmpty
            ? Center(child: Text(emptyText))
            : ListView(children: [for (final b in list) _TripTile(b)]),
      );
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry(this.msg, this.onRetry);
  final String msg;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Error: $msg', textAlign: TextAlign.center),
            const SizedBox(height: 8),
            FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
          ]),
        ),
      );
}

// ─────────────────────────── mode: between from→to ──────────────────────────

class _BetweenSearch extends ConsumerStatefulWidget {
  const _BetweenSearch({required this.category});
  final ServiceCategory category;
  @override
  ConsumerState<_BetweenSearch> createState() => _BetweenSearchState();
}

class _BetweenSearchState extends ConsumerState<_BetweenSearch> {
  Stop? _from;
  Stop? _to;

  bool get _isDistrict => widget.category == ServiceCategory.district;
  // Official rule: District ("Inter") = operationType 1; City/Airport = 2.
  // NOTE: this is the SEARCH op, distinct from ServiceCategory.operationType
  // (which the route-list browse uses).
  int get _op => _isDistrict ? 1 : 2;
  String _geoOf(Stop s) => s.geozoneType ?? (_isDistrict ? 'place' : 'stage');

  Future<void> _pick(bool isFrom, List<Stop> stops) async {
    final picked = await showModalBottomSheet<Stop>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _StopPicker(stops: stops, title: isFrom ? 'From' : 'To'),
    );
    if (picked != null) setState(() => isFrom ? _from = picked : _to = picked);
  }

  @override
  Widget build(BuildContext context) {
    final stopsAsync = _isDistrict
        ? ref.watch(districtStopsProvider)
        : ref.watch(cityStageStopsProvider);
    final ready = _from != null && _to != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: const EdgeInsets.all(12),
          child: stopsAsync.when(
            loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator())),
            error: (e, _) =>
                Padding(padding: const EdgeInsets.all(16), child: Text('$e')),
            data: (stops) => Row(
              children: [
                Expanded(
                  child: Column(children: [
                    _EndpointTile(
                        label: 'FROM',
                        value: _from?.name,
                        icon: Icons.trip_origin,
                        onTap: () => _pick(true, stops)),
                    const Divider(height: 1),
                    _EndpointTile(
                        label: 'TO',
                        value: _to?.name,
                        icon: Icons.place,
                        onTap: () => _pick(false, stops)),
                  ]),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_vert),
                  tooltip: 'Swap',
                  onPressed: () => setState(() {
                    final t = _from;
                    _from = _to;
                    _to = t;
                  }),
                ),
              ],
            ),
          ),
        ),
        if (!ready)
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('Pick a start and destination to see buses\n'
                    'running now and the scheduled timetable.',
                    textAlign: TextAlign.center),
              ),
            ),
          )
        else
          Expanded(
              child: _BetweenResults(
                  key: ValueKey('${_from!.id}_${_to!.id}'),
                  fromId: _from!.id,
                  toId: _to!.id,
                  fromGeo: _geoOf(_from!),
                  toGeo: _geoOf(_to!),
                  op: _op)),
      ],
    );
  }
}

class _BetweenResults extends ConsumerStatefulWidget {
  const _BetweenResults(
      {super.key,
      required this.fromId,
      required this.toId,
      required this.fromGeo,
      required this.toGeo,
      required this.op});
  final String fromId, toId, fromGeo, toGeo;
  final int op;

  @override
  ConsumerState<_BetweenResults> createState() => _BetweenResultsState();
}

class _BetweenResultsState extends ConsumerState<_BetweenResults> {
  bool _showSchedule = false;

  @override
  Widget build(BuildContext context) {
    final key = (widget.fromId, widget.toId, widget.fromGeo, widget.toGeo, widget.op);
    final live = ref.watch(betweenLiveProvider(key));
    return ListView(
      children: [
        _Section(icon: Icons.sensors, title: 'Running now', color: Colors.green),
        live.when(
          loading: () => const _Pad(child: Center(child: CircularProgressIndicator())),
          error: (e, _) => _Pad(child: Text('$e')),
          data: (b) => b.isEmpty
              ? const _Pad(child: Text('No buses running on this route right now.'))
              : Column(children: [for (final x in b) _TripTile(x)]),
        ),
        const Divider(height: 24),
        // Scheduled is loaded ONLY on demand — the timetable call is slow, and
        // the official app shows it on a separate screen too.
        if (!_showSchedule)
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton.icon(
              onPressed: () => setState(() => _showSchedule = true),
              icon: const Icon(Icons.schedule),
              label: const Text('Show full timetable'),
            ),
          )
        else ...[
          _Section(
              icon: Icons.schedule,
              title: 'Scheduled',
              color: Theme.of(context).colorScheme.primary),
          ref.watch(betweenPlannedProvider(key)).when(
                loading: () => const _Pad(
                  child: Column(children: [
                    SizedBox(height: 8),
                    Center(child: CircularProgressIndicator()),
                    SizedBox(height: 10),
                    Text('Fetching timetable — this can take up to a minute.',
                        textAlign: TextAlign.center),
                  ]),
                ),
                error: (e, _) => _Pad(child: Text('$e')),
                data: (t) => t.isEmpty
                    ? const _Pad(child: Text('No scheduled services found.'))
                    : Column(children: [for (final x in t) _PlannedTile(x)]),
              ),
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}

class _PlannedTile extends StatelessWidget {
  const _PlannedTile(this.trip);
  final PlannedTrip trip;
  @override
  Widget build(BuildContext context) {
    final dep = _hhmm(trip.from?.plannedAt), arr = _hhmm(trip.to?.plannedAt);
    return ListTile(
      leading: const Icon(Icons.schedule_outlined),
      title: Text(trip.serviceType ?? trip.serviceName ?? 'Service'),
      subtitle: Text([
        if (dep.isNotEmpty && arr.isNotEmpty) '$dep → $arr',
        if (trip.minutes != null) '${trip.minutes} min',
        if (trip.totalStops != null) '${trip.totalStops} stops',
      ].join('  ·  ')),
    );
  }
}

// ─────────────────────────── mode: route number ─────────────────────────────

class _RouteNumberSearch extends ConsumerStatefulWidget {
  const _RouteNumberSearch();
  @override
  ConsumerState<_RouteNumberSearch> createState() => _RouteNumberSearchState();
}

class _RouteNumberSearchState extends ConsumerState<_RouteNumberSearch> {
  String _q = '';
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _SearchField(
          hint: 'Enter route number (e.g. 10H)',
          onChanged: (v) => setState(() => _q = v.trim())),
      Expanded(
        child: _q.isEmpty
            ? const _Hint('Type a route number to find its buses.')
            : _AsyncTrips(
                value: ref.watch(routeSearchProvider(_q)),
                onRetry: () => ref.invalidate(routeSearchProvider(_q)),
                emptyText: 'No buses for route "$_q" right now.'),
      ),
    ]);
  }
}

// ─────────────────────────── mode: bus number ───────────────────────────────

class _BusNumberSearch extends ConsumerStatefulWidget {
  const _BusNumberSearch();
  @override
  ConsumerState<_BusNumberSearch> createState() => _BusNumberSearchState();
}

class _BusNumberSearchState extends ConsumerState<_BusNumberSearch> {
  String _q = '';
  @override
  Widget build(BuildContext context) {
    final async = ref.watch(busNumbersProvider);
    return Column(children: [
      _SearchField(
          hint: 'Enter bus number (e.g. TS08Z0127)',
          onChanged: (v) => setState(() => _q = v.trim().toUpperCase())),
      Expanded(
        child: async.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _ErrorRetry('$e', () => ref.invalidate(busNumbersProvider)),
          data: (buses) {
            if (_q.isEmpty) {
              return const _Hint('Type a bus registration number to track it.');
            }
            final hits = buses
                .where((b) => (b.registrationNumber ?? b.name)
                    .toUpperCase()
                    .contains(_q))
                .take(40)
                .toList();
            if (hits.isEmpty) return Center(child: Text('No bus matches "$_q".'));
            return ListView(children: [
              for (final v in hits)
                ListTile(
                  leading: const Icon(Icons.directions_bus_outlined),
                  title: Text(v.registrationNumber ?? v.name),
                  subtitle: Text(v.serviceType ?? '—'),
                  trailing: const Icon(Icons.my_location, size: 20),
                  onTap: () => _track(context,
                      vehicleId: v.id, title: v.registrationNumber ?? v.name),
                ),
            ]);
          },
        ),
      ),
    ]);
  }
}

// ─────────────────────────── mode: service number ───────────────────────────

class _ServiceNumberSearch extends ConsumerStatefulWidget {
  const _ServiceNumberSearch();
  @override
  ConsumerState<_ServiceNumberSearch> createState() => _ServiceNumberSearchState();
}

class _ServiceNumberSearchState extends ConsumerState<_ServiceNumberSearch> {
  String _q = '';
  @override
  Widget build(BuildContext context) {
    // A service/reservation number IS searched via the routeNumber endpoint
    // (op=1 for district), matching on serviceName — e.g. "8924" returns its
    // running bus. The dedicated service-trip endpoint returns empty, so we
    // use the same proven path as route search.
    return Column(children: [
      _SearchField(
          hint: 'Enter service / reservation number (e.g. 8924)',
          onChanged: (v) => setState(() => _q = v.trim())),
      Expanded(
        child: _q.isEmpty
            ? const _Hint('Type a service number to find its bus.')
            : _AsyncTrips(
                value: ref.watch(routeSearchProvider(_q)),
                onRetry: () => ref.invalidate(routeSearchProvider(_q)),
                emptyText: 'No bus for service "$_q" right now.'),
      ),
    ]);
  }
}

// ─────────────────────────── small shared widgets ───────────────────────────

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hint, required this.onChanged});
  final String hint;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.search,
          onChanged: onChanged,
        ),
      );
}

class _EndpointTile extends StatelessWidget {
  const _EndpointTile(
      {required this.label, required this.value, required this.icon, required this.onTap});
  final String label;
  final String? value;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: t.colorScheme.primary),
      title: Text(label,
          style: t.textTheme.labelSmall?.copyWith(color: t.colorScheme.onSurfaceVariant)),
      subtitle: Text(value ?? 'Select',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: t.textTheme.titleMedium?.copyWith(
              color: value == null ? t.colorScheme.onSurfaceVariant : null)),
      onTap: onTap,
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.icon, required this.title, required this.color});
  final IconData icon;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Row(children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ]),
      );
}

class _Pad extends StatelessWidget {
  const _Pad({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) =>
      Padding(padding: const EdgeInsets.fromLTRB(16, 4, 16, 8), child: child);
}

class _Hint extends StatelessWidget {
  const _Hint(this.text);
  final String text;
  @override
  Widget build(BuildContext context) =>
      Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(text, textAlign: TextAlign.center)));
}

class _StopPicker extends StatefulWidget {
  const _StopPicker({required this.stops, required this.title});
  final List<Stop> stops;
  final String title;
  @override
  State<_StopPicker> createState() => _StopPickerState();
}

class _StopPickerState extends State<_StopPicker> {
  String _q = '';
  @override
  Widget build(BuildContext context) {
    final filtered = _q.isEmpty
        ? widget.stops
        : widget.stops.where((s) => s.name.toLowerCase().contains(_q)).toList();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
                labelText: '${widget.title} — search',
                prefixIcon: const Icon(Icons.search)),
            onChanged: (v) => setState(() => _q = v.toLowerCase()),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (_, i) => ListTile(
              leading: const Icon(Icons.place_outlined),
              title: Text(filtered[i].name),
              onTap: () => Navigator.pop(context, filtered[i]),
            ),
          ),
        ),
      ]),
    );
  }
}
