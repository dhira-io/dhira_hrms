import 'dart:convert';
import 'package:dio/dio.dart';
import '../error/exceptions.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'session_manager.dart';

class DioClient {
  final Dio dio;
  final String baseUrl;
  final SessionManager sessionManager;

  DioClient(
    this.dio,
    this.sessionManager, {
    required this.baseUrl,
    required AuthInterceptor authInterceptor,
    required LoggingInterceptor loggingInterceptor,
  }) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.interceptors.addAll([authInterceptor, loggingInterceptor]);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkException(message: 'Connection Timeout');
    }

    if (e.response != null) {
      if (e.response?.statusCode == 401) {
        sessionManager.triggerSessionExpired();
        return UnauthorizedException(message: 'Unauthorized');
      }

      String? errorMessage;
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        errorMessage = data['message'] ??
            data['error'] ??
            data['errorMessage'] ??
            data['_error_message']; // Frappe explicit error message

        // Handle Frappe-style server messages (list of JSON strings)
        if (errorMessage == null && data['_server_messages'] != null) {
          try {
            final List messages = data['_server_messages'] is String
                ? jsonDecode(data['_server_messages'])
                : data['_server_messages'];
            if (messages.isNotEmpty) {
              final firstMessage = jsonDecode(messages.first);
              errorMessage = firstMessage['message'];
              // Strip HTML tags if present
              errorMessage = errorMessage?.replaceAll(RegExp(r'<[^>]*>'), '');
            }
          } catch (_) {
            // Fallback if parsing fails
          }
        }

        // Handle Frappe-style exceptions
        if (errorMessage == null && data['exception'] != null) {
          final String exceptionStr = data['exception'].toString();
          if (exceptionStr.contains(':')) {
            final parts = exceptionStr.split(':');
            errorMessage = parts.sublist(1).join(':').trim();
          } else {
            errorMessage = exceptionStr;
          }
        }
      } else if (data is String && data.isNotEmpty) {
        errorMessage = data;
      }

      return ServerException(
        message: errorMessage ?? 'Something went wrong',
        code: e.response?.statusCode,
      );
    }

    return NetworkException(message: 'No Internet Connection');
  }
}
