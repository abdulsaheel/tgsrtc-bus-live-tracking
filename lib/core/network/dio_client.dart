import 'package:dio/dio.dart';

import '../config/app_config.dart';
import 'auth_interceptor.dart';

/// Builds the configured Dio for the TGSRTC data API.
///
/// Base URL comes from [AppConfig.dataBaseUrl] — the single switch between
/// direct-Mappls and the future Cloudflare proxy. Nothing else in the app
/// hardcodes a host.
Dio buildDataDio() {
  final tokenDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.dataBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.add(AuthInterceptor(tokenDio));
  return dio;
}
