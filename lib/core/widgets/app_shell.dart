import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/track/presentation/journey_live_activity.dart';

/// Bottom-nav shell (≤5 items, icon + label per a11y guidance).
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  static const _destinations = [
    NavigationDestination(
      icon: Icon(Icons.my_location_outlined),
      selectedIcon: Icon(Icons.my_location),
      label: 'Track',
    ),
    NavigationDestination(
      icon: Icon(Icons.near_me_outlined),
      selectedIcon: Icon(Icons.near_me),
      label: 'Nearby',
    ),
    NavigationDestination(
      icon: Icon(Icons.directions_outlined),
      selectedIcon: Icon(Icons.directions),
      label: 'Plan',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          shell,
          const JourneyLiveActivity(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        destinations: _destinations,
        onDestinationSelected: (i) => shell.goBranch(
          i,
          initialLocation: i == shell.currentIndex,
        ),
      ),
    );
  }
}
