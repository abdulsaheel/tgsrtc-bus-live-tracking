import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/async_view.dart';
import '../../../data/models/bus_service.dart';
import '../../../data/models/bus_trip.dart';
import '../providers/track_providers.dart';

/// Shows the live buses currently running a given route, in a bottom sheet.
/// Tapping a bus opens the live tracking screen.
void showRouteBuses(BuildContext context, {required BusService route}) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) => _RouteBusesSheet(route: route),
  );
}

class _RouteBusesSheet extends ConsumerWidget {
  const _RouteBusesSheet({required this.route});
  final BusService route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Prefer the route number; fall back to the service name.
    final query = (route.routeNumber?.isNotEmpty == true)
        ? route.routeNumber!
        : route.name;
    final buses = ref.watch(routeSearchProvider(query));

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                route.routeNumber?.isNotEmpty == true
                    ? 'Route ${route.routeNumber} · ${route.name}'
                    : route.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Flexible(
              child: AsyncView<List<BusTrip>>(
                value: buses,
                onRetry: () => ref.invalidate(routeSearchProvider(query)),
                isEmpty: (l) => l.isEmpty,
                empty: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'No live buses on this route right now.',
                    textAlign: TextAlign.center,
                  ),
                ),
                data: (list) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    final t = list[i];
                    return ListTile(
                      key: ValueKey(t.id),
                      leading: const Icon(Icons.directions_bus),
                      title: Text(t.vehicleNumber ?? t.serviceName ?? 'Bus'),
                      subtitle: t.from?.name != null && t.to?.name != null
                          ? Text('${t.from!.name} → ${t.to!.name}')
                          : null,
                      trailing: const Icon(Icons.my_location),
                      onTap: t.vehicleId == null
                          ? null
                          : () {
                              Navigator.pop(context);
                              context.pushNamed('live', pathParameters: {
                                'vehicleId': '${t.vehicleId}',
                              }, queryParameters: {
                                'title': t.vehicleNumber ??
                                    t.serviceName ??
                                    'Live bus',
                                'tripId': '${t.id}',
                              });
                            },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
