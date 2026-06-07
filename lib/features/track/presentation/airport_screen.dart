import 'package:flutter/material.dart';

import '../../../data/models/service_category.dart';
import 'route_browser.dart';

/// Airport bus services (Pushpak etc.) for the selected city.
class AirportScreen extends StatelessWidget {
  const AirportScreen({super.key});

  @override
  Widget build(BuildContext context) => const RouteBrowserScreen(
        category: ServiceCategory.airport,
        title: 'Airport Buses',
        searchHint: 'e.g. Pushpak, WE',
      );
}
