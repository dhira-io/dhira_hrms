import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class AuthService {
  final GlobalKey<NavigatorState> navigatorKey;
  late final AadOAuth _oauth;

  AuthService({ required this.navigatorKey }) {
    final config = Config(
      tenant: "9158051d-2df2-4f79-8b5e-90a62414be5a",
      clientId: "fe4286f6-8516-4e10-930d-399efcd185af",
      scope: "openid profile offline_access User.Read",
      redirectUri: "msalfe4286f6-8516-4e10-930d-399efcd185af://auth",
      navigatorKey: navigatorKey,
    );
    _oauth = AadOAuth(config);
  }

  Future<Map<String, dynamic>?> mslogin() async {
    try {
      await _oauth.login();
      final accessToken = await _oauth.getAccessToken();
      if (accessToken == null) return null;
      final userInfo = await _fetchUser(accessToken);
      print("ms login userinfo =$userInfo");
      return userInfo;
    } catch (e) {
      print("msLogin error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> _fetchUser(String accessToken) async {
    final url = Uri.parse("https://graph.microsoft.com/v1.0/me");
    final resp = await http.get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );
    if (resp.statusCode == 200) {
      print("mslogin fetchuser =${resp.body}");
      return json.decode(resp.body);
    } else {
      throw Exception("Failed to fetch user info: ${resp.body}");
    }
  }

  Future<void> mslogout() async {
    await _oauth.logout();
  }
}
