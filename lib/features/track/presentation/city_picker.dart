import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/async_view.dart';
import '../../../data/models/city.dart';
import '../providers/track_providers.dart';

/// Bottom sheet to pick a city. Also offers "Detect automatically".
void showCityPicker(BuildContext context, WidgetRef ref) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) => const _CityPickerSheet(),
  );
}

class _CityPickerSheet extends ConsumerWidget {
  const _CityPickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cities = ref.watch(citiesProvider);
    final selected = ref.watch(selectedCityProvider);
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
              child: Text('Choose your city',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            ListTile(
              leading: const Icon(Icons.my_location),
              title: const Text('Detect automatically'),
              onTap: () async {
                Navigator.pop(context);
                ref.invalidate(cityInitProvider); // re-run detection
              },
            ),
            const Divider(height: 1),
            Flexible(
              child: AsyncView<List<City>>(
                value: cities,
                onRetry: () => ref.invalidate(citiesProvider),
                data: (list) => ListView(
                  shrinkWrap: true,
                  children: [
                    for (final c in list)
                      ListTile(
                        leading: Icon(
                          c.id == selected?.id
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: c.id == selected?.id
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        title: Text(c.name),
                        onTap: () async {
                          await chooseCity(ref, c);
                          if (context.mounted) Navigator.pop(context);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Full-screen prompt shown when no city could be resolved on launch.
class CityPickerPrompt extends ConsumerWidget {
  const CityPickerPrompt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_searching,
                size: 56, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 12),
            Text('Which city are you in?', style: t.titleMedium),
            const SizedBox(height: 4),
            Text(
              "We couldn't detect a TGSRTC city near you. Pick one to see live buses.",
              style: t.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => showCityPicker(context, ref),
              icon: const Icon(Icons.location_city_outlined),
              label: const Text('Choose city'),
            ),
          ],
        ),
      ),
    );
  }
}
