import 'package:dio/dio.dart';

import '../config/app_config.dart';

/// Attaches a Mappls OAuth bearer token to data-API requests and transparently
/// refreshes it on 401. In PROXY mode this is a no-op: the proxy injects auth
/// server-side, so the client never holds credentials.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenDio);

  /// A separate Dio (no interceptors) used only to fetch tokens, to avoid
  /// recursive interception.
  final Dio _tokenDio;

  String? _token;
  DateTime? _expiry;

  bool get _isValid =>
      _token != null && _expiry != null && DateTime.now().isBefore(_expiry!);

  Future<String?> _ensureToken() async {
    if (AppConfig.useProxy) return null; // proxy handles auth
    if (_isValid) return _token;
    await _fetchToken();
    return _token;
  }

  Future<void> _fetchToken() async {
    final res = await _tokenDio.post<Map<String, dynamic>>(
      '${AppConfig.authBaseUrl}/api/security/oauth/token',
      data: {
        'grant_type': 'client_credentials',
        'client_id': AppConfig.clientId,
        'client_secret': AppConfig.clientSecret,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final data = res.data!;
    _token = data['access_token'] as String?;
    final expiresIn = (data['expires_in'] as num?)?.toInt() ?? 3600;
    // Refresh 30s early.
    _expiry = DateTime.now().add(Duration(seconds: expiresIn - 30));
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _ensureToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // One retry on auth failure with a fresh token (direct mode only).
    if (!AppConfig.useProxy &&
        err.response?.statusCode == 401 &&
        err.requestOptions.extra['retried'] != true) {
      try {
        await _fetchToken();
        final opts = err.requestOptions
          ..extra['retried'] = true
          ..headers['Authorization'] = 'Bearer $_token';
        final clone = await _tokenDio.fetch<dynamic>(opts);
        return handler.resolve(clone);
      } catch (_) {
        // fall through to original error
      }
    }
    handler.next(err);
  }
}
