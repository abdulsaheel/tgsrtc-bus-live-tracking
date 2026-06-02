import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

/// Shared basemap tile layer. Uses CARTO Voyager (light) / Dark Matter (dark) —
/// modern, high-resolution (@2x retina), and far less cluttered than raw OSM
/// (minimal POI labels until you zoom in). Theme-aware.
///
/// Attribution: © OpenStreetMap contributors © CARTO. For production, register
/// for a CARTO key (free tier) — fine without one for development.
TileLayer buildBaseTileLayer(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final style = isDark ? 'dark_all' : 'voyager';
  return TileLayer(
    urlTemplate:
        'https://basemaps.cartocdn.com/rastertiles/$style/{z}/{x}/{y}{r}.png',
    retinaMode: RetinaMode.isHighDensity(context),
    userAgentPackageName: 'com.abdulsaheel.tsrtcbustracker',
    maxNativeZoom: 20,
  );
}

/// Standard attribution widget to satisfy OSM/CARTO terms.
Widget mapAttribution() => const RichAttributionWidget(
      attributions: [
        TextSourceAttribution('OpenStreetMap contributors'),
        TextSourceAttribution('CARTO'),
      ],
    );
