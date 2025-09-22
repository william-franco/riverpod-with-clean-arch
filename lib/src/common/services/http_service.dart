import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

typedef HttpResult = ({int? statusCode, Object? data, String? error});

abstract interface class HttpService {
  Future<HttpResult> getData({required String path});
}

class HttpServiceImpl implements HttpService {
  final _httpClient = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  HttpServiceImpl() {
    _httpClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('➡️ Request to: ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('✅ Response: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          debugPrint('❌ Dio error: ${e.message}');
          int retryCount = 0;
          int maxRetries = 3;

          while (retryCount < maxRetries &&
              e.type == DioExceptionType.connectionTimeout) {
            retryCount++;
            debugPrint('⏳ Retrying ($retryCount/$maxRetries)...');
            try {
              final res = await _httpClient.request(e.requestOptions.path);
              return handler.resolve(res);
            } catch (_) {}
          }
          return handler.next(e);
        },
      ),
    );
  }

  HttpResult _handleResponse(Response response) =>
      (statusCode: response.statusCode, data: response.data, error: null);

  HttpResult _handleError(DioException error) => (
    statusCode: error.response?.statusCode,
    data: null,
    error: error.message,
  );

  HttpResult _handleGenericError(Object error) =>
      (statusCode: null, data: null, error: '$error');

  @override
  Future<HttpResult> getData({
    required String path,
    bool useAuth = true,
  }) async {
    try {
      final response = await _httpClient.get(path);
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return _handleGenericError(e);
    }
  }
}
