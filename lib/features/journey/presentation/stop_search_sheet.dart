import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/async_view.dart';
import '../../../data/models/stop.dart';
import '../providers/journey_providers.dart';

/// Searchable stage-stop picker. Calls [onSelected] with the chosen stop.
void showStopSearch(BuildContext context,
    {required ValueChanged<Stop> onSelected}) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) => _StopSearchSheet(onSelected: onSelected),
  );
}

class _StopSearchSheet extends ConsumerStatefulWidget {
  const _StopSearchSheet({required this.onSelected});
  final ValueChanged<Stop> onSelected;

  @override
  ConsumerState<_StopSearchSheet> createState() => _StopSearchSheetState();
}

class _StopSearchSheetState extends ConsumerState<_StopSearchSheet> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final stops = ref.watch(cityStopsProvider);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Search stop',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (v) => setState(() => _q = v.toLowerCase()),
              ),
            ),
            Expanded(
              child: AsyncView<List<Stop>>(
                value: stops,
                onRetry: () => ref.invalidate(cityStopsProvider),
                data: (list) {
                  final filtered = _q.isEmpty
                      ? list
                      : list
                          .where((s) => s.name.toLowerCase().contains(_q))
                          .toList();
                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final s = filtered[i];
                      return ListTile(
                        key: ValueKey(s.id),
                        leading: const Icon(Icons.location_on_outlined),
                        title: Text(s.name),
                        onTap: () {
                          widget.onSelected(s);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
