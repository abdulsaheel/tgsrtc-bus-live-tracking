import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Central runtime configuration.
///
/// THE KEY ABSTRACTION: every network call routes through [dataBaseUrl] and
/// [authBaseUrl]. Today these point straight at Mappls. When the Cloudflare
/// Worker proxy ships, change ONLY these two values (via .env) and the whole
/// app talks to the proxy instead — no other code changes. Credentials then
/// live in the Worker, never in this client.
class AppConfig {
  const AppConfig._();

  /// Whether the app talks to Mappls directly (prototyping) or via our proxy.
  /// When the proxy is live, set USE_PROXY=true and PROXY_BASE_URL in .env.
  static bool get useProxy =>
      (dotenv.maybeGet('USE_PROXY') ?? 'false').toLowerCase() == 'true';

  static String get _proxyBaseUrl =>
      dotenv.maybeGet('PROXY_BASE_URL') ?? 'https://gamyam-proxy.example.workers.dev';

  // --- Direct Mappls (prototyping only) ---
  static const String _mapplsAuthBase = 'https://outpost.mapmyindia.com';
  static const String _mapplsDataBase = 'https://intouch.mapmyindia.com';

  /// Base URL for OAuth token requests. In proxy mode the proxy mints/forwards
  /// tokens server-side, so the app may not need this at all.
  static String get authBaseUrl => useProxy ? _proxyBaseUrl : _mapplsAuthBase;

  /// Base URL for the TGSRTC data API.
  /// Direct: https://intouch.mapmyindia.com/tsrtc/api
  /// Proxy:  https://WORKER/tsrtc/api   (proxy injects auth)
  static String get dataBaseUrl =>
      useProxy ? '$_proxyBaseUrl/tsrtc/api' : '$_mapplsDataBase/tsrtc/api';

  // --- Mappls OAuth client credentials (prototyping ONLY) ---
  // ⚠️ These are recovered from the original app's native lib. They MUST move
  // to the proxy before any public release. Read from .env so they are never
  // hardcoded in source / committed.
  static String get clientId => dotenv.maybeGet('MAPPLS_CLIENT_ID') ?? '';
  static String get clientSecret => dotenv.maybeGet('MAPPLS_CLIENT_SECRET') ?? '';

  // --- Live tracking ---
  static const Duration livePollInterval = Duration(seconds: 8);
  static const Duration gpsStaleThreshold = Duration(seconds: 60);

  /// External booking portal (the old app's WebView target).
  static const String bookingUrl = 'https://tsrtconline.in/oprs-web';
}
