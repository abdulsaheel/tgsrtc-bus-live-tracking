import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_config.dart';

/// About / disclaimer dialog. Crucially carries the "unofficial" notice so the
/// app is never mistaken for an official TGSRTC product.
void showGamyamAbout(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (_) => const _AboutDialog(),
  );
}

class _AboutDialog extends StatelessWidget {
  const _AboutDialog();

  // TODO: confirm with developer — name / handle / link to show as credit.
  static const _developer = 'Sahil';
  static const _developerLink = ''; // e.g. https://github.com/...

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Gamyam'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live bus tracking for Telangana.',
              style: theme.textTheme.bodyMedium),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Unofficial app — not affiliated with, endorsed by, or '
                    'operated by TGSRTC. Bus data is sourced from public '
                    'tracking feeds and may be inaccurate or delayed.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _developerLink.isEmpty
                ? null
                : () => launchUrl(Uri.parse(_developerLink),
                    mode: LaunchMode.externalApplication),
            child: Row(
              children: [
                const Icon(Icons.code, size: 18),
                const SizedBox(width: 8),
                Text('Built by $_developer',
                    style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.confirmation_number_outlined),
            title: const Text('Book a ticket'),
            subtitle: const Text('Opens the official booking site'),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: () => launchUrl(Uri.parse(AppConfig.bookingUrl),
                mode: LaunchMode.externalApplication),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
