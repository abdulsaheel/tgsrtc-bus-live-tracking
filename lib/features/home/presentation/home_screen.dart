import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/about_dialog.dart';

/// Landing screen: a grid of dedicated destinations (City / District / Airport /
/// Near me / Plan), each its own full screen. Mirrors the official app's home.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 12, 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TGSRTC',
                              style: theme.textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w800)),
                          Text('Live bus tracking for Telangana',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      tooltip: 'About',
                      onPressed: () => showGamyamAbout(context),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.05,
                ),
                delegate: SliverChildListDelegate([
                  _HomeCard(
                    title: 'City Buses',
                    subtitle: 'Routes in your city',
                    icon: Icons.location_city,
                    color: AppColors.primary,
                    onTap: () => context.pushNamed('city'),
                  ),
                  _HomeCard(
                    title: 'District Buses',
                    subtitle: 'Between two places',
                    icon: Icons.alt_route,
                    color: AppColors.secondary,
                    onTap: () => context.pushNamed('district'),
                  ),
                  _HomeCard(
                    title: 'Airport Buses',
                    subtitle: 'Pushpak & airport',
                    icon: Icons.flight_takeoff,
                    color: const Color(0xFF7C3AED),
                    onTap: () => context.pushNamed('airport'),
                  ),
                  _HomeCard(
                    title: 'Near Me',
                    subtitle: 'Stops & buses nearby',
                    icon: Icons.near_me,
                    color: const Color(0xFF0EA5E9),
                    onTap: () => context.pushNamed('nearby'),
                  ),
                  _HomeCard(
                    title: 'Plan a Trip',
                    subtitle: 'Stop to stop',
                    icon: Icons.directions,
                    color: const Color(0xFFEA580C),
                    onTap: () => context.pushNamed('plan'),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
