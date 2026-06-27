import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/storage_constants.dart';
import '../../../features/auth/data/constants/auth_api_constants.dart';
import '../session_manager.dart';

class AuthInterceptor extends Interceptor {
  final SharedPreferences _prefs;
  final SessionManager _sessionManager;

  AuthInterceptor(this._prefs, this._sessionManager);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Inject Cookies
    final cookieString = _prefs.getString(StorageConstants.cookies);
    if (cookieString != null) {
      final Map<String, dynamic> cookieMap = json.decode(cookieString);
      final cookieHeader = cookieMap.entries
          .map((e) => "${e.key}=${e.value}")
          .join("; ");
      options.headers["Cookie"] = cookieHeader;
    }

    // Standard Headers from Legacy
    final baseHeaders = {'Accept': 'application/json'};

    if (options.method != 'GET') {
      baseHeaders['Content-Type'] = 'application/x-www-form-urlencoded';
    }

    // options.headers.addAll(baseHeaders);
    baseHeaders.forEach((key, value) {
      options.headers.putIfAbsent(key, () => value);
    });
    // Standard Headers - Only set if not already specified
    options.headers.putIfAbsent('Content-Type', () => 'application/json');
    options.headers.putIfAbsent('Accept', () => 'application/json');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Save Cookies from Response
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
        final existingCookieString = _prefs.getString(StorageConstants.cookies);
        Map<String, dynamic> existingCookieMap = {};
        if (existingCookieString != null) {
          try {
            existingCookieMap = json.decode(existingCookieString);
          } catch (_) {}
        }
        final mergedCookies = {
          ...existingCookieMap,
          ...cookieMap,
        };
        // IMPORTANT: We must wait for the save to complete to avoid race conditions
        // with the Repository reading cookies immediately after login/SSO.
        await _prefs.setString(
          StorageConstants.cookies,
          json.encode(mergedCookies),
        );
      }
    }

    // Trigger Session Expiry on 401/403, but NOT for login requests
    final isLoginRequest =
        response.requestOptions.path.contains(AuthApiConstants.login) ||
        response.requestOptions.path.contains(AuthApiConstants.msLogin);

    bool isSessionExpired = response.statusCode == 401;
    if (response.statusCode == 403 && response.data is Map) {
      final data = response.data as Map;
      if (data['session_expired'] == 1 || data['session_expired'] == '1') {
        isSessionExpired = true;
      }
    }

    if (isSessionExpired && !isLoginRequest) {
      _sessionManager.triggerSessionExpired();
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final isLoginRequest =
        err.requestOptions.path.contains(AuthApiConstants.login) ||
        err.requestOptions.path.contains(AuthApiConstants.msLogin);

    bool isSessionExpired = err.response?.statusCode == 401;
    if (err.response?.statusCode == 403 && err.response?.data is Map) {
      final data = err.response?.data as Map;
      if (data['session_expired'] == 1 || data['session_expired'] == '1') {
        isSessionExpired = true;
      }
    }

    if (isSessionExpired && !isLoginRequest) {
      _sessionManager.triggerSessionExpired();
    }
    return super.onError(err, handler);
  }
}
