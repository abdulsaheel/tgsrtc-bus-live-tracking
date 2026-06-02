import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/journey_controller.dart';

/// Floating "live activity" pill shown while following a bus (in-app mirror of
/// the foreground-service notification). Driven by [journeyControllerProvider],
/// which is fed live data from the background isolate.
class JourneyLiveActivity extends ConsumerWidget {
  const JourneyLiveActivity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final j = ref.watch(journeyControllerProvider);
    if (!j.isFollowing) return const SizedBox.shrink();

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Material(
            color: const Color(0xFF101418),
            borderRadius: BorderRadius.circular(20),
            elevation: 6,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => context.pushNamed('live', pathParameters: {
                'vehicleId': '${j.vehicleId}',
              }, queryParameters: {
                'title': j.title ?? 'Live bus',
                if (j.tripId != null) 'tripId': '${j.tripId}',
              }),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
                child: Row(
                  children: [
                    const _PulseDot(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            j.title ?? 'Live tracking',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            j.nextStop != null
                                ? 'Towards ${j.nextStop}  ·  ${j.speedKph.round()} km/h'
                                : 'Tracking · ${j.speedKph.round()} km/h',
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: j.progress.clamp(0.0, 1.0),
                              minHeight: 3,
                              backgroundColor: Colors.white12,
                              valueColor: const AlwaysStoppedAnimation(
                                  AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white54),
                      tooltip: 'Stop following',
                      onPressed: () => ref
                          .read(journeyControllerProvider.notifier)
                          .stopFollowing(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  const _PulseDot();
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.4, end: 1.0).animate(_c),
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: AppColors.statusRunning,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
