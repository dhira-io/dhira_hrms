import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/storage_constants.dart';

class AuthInterceptor extends Interceptor {
  final SharedPreferences _prefs;

  AuthInterceptor(this._prefs);

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
      options.headers["cookie"] = cookieHeader;
    }

    // Standard Platform Headers from Template
    final packageInfo = await PackageInfo.fromPlatform();
    options.headers.addAll({
      'zone': DateTime.now().timeZoneName,
      'buildVersionCode': packageInfo.buildNumber,
      'buildVersionName': packageInfo.version,
      'platform': Platform.isAndroid ? 'Android' : 'iOS',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
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
        await _prefs.setString(StorageConstants.cookies, json.encode(cookieMap));
      }
    }
    return super.onResponse(response, handler);
  }
}
