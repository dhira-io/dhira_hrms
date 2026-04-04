import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_constants.dart';

class DioClient {
  final Dio dio;
  final Logger logger;
  final String baseUrl;

  DioClient(this.dio, this.logger, {this.baseUrl = "https://dev-hrms.akashic.dhira.io/"}) {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => logger.d(obj),
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final cookieString = prefs.getString(StorageConstants.cookies);
        if (cookieString != null) {
          final Map<String, dynamic> cookieMap = json.decode(cookieString);
          final cookieHeader = cookieMap.entries
              .map((e) => "${e.key}=${e.value}")
              .join("; ");
          options.headers["cookie"] = cookieHeader;
        }
        options.headers["Content-Type"] = "application/x-www-form-urlencoded";
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        final rawCookie = response.headers["set-cookie"];
        if (rawCookie != null) {
          final List<String> cookies = rawCookie;
          final Map<String, String> cookieMap = {};
          for (var cookie in cookies) {
            final cookieParts = cookie.split(';')[0].split('=');
            if (cookieParts.length == 2) {
              cookieMap[cookieParts[0].trim()] = cookieParts[1].trim();
            }
          }
          if (cookieMap.isNotEmpty) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(StorageConstants.cookies, json.encode(cookieMap));
          }
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await dio.put(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await dio.delete(path, data: data, queryParameters: queryParameters);
  }
}
