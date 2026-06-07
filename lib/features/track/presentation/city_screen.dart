import 'package:flutter/material.dart';

import '../../../data/models/service_category.dart';
import 'bus_search_screen.dart';

/// City bus services — search between stops, by route number, or by bus number.
class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) => const BusSearchScreen(
        category: ServiceCategory.city,
        title: 'City Buses',
      );
}
