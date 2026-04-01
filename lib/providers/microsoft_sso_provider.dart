import 'dart:convert';
import 'package:dhira_hrms/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/main_screen.dart';
import 'login_provider.dart';

class MicrosoftSSOProvider extends ChangeNotifier {
  late final AppLinks _appLinks;
  BuildContext? _context;

  void init(BuildContext context) {
    _context = context;
    _initDeepLinks();
  }

  // --------------------------------------------------------
  // SETUP DEEP LINKS
  // --------------------------------------------------------
  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Cold start
    final uri = await _appLinks.getInitialLink();
    if (uri != null) _handleIncomingUri(uri);

    // App running
    _appLinks.uriLinkStream.listen((uri) {
      if (uri != null) _handleIncomingUri(uri);
    });
  }

  // --------------------------------------------------------
  // HANDLE INCOMING Frappe CALLBACK
  // --------------------------------------------------------
  void _handleIncomingUri(Uri uri) async {
    debugPrint("Received deep link: $uri");

    if (uri.scheme == "com.dhira.hrms" &&
        uri.host == "auth" &&
        uri.path == "/callback") {

      final success = uri.queryParameters["success"];
      final apiKey = uri.queryParameters["api_key"];
      final apiSecret = uri.queryParameters["api_secret"];
      final error = uri.queryParameters["error"];

      if (success == "true" && apiKey != null && apiSecret != null) {
      await exchangeToken(apiKey, apiSecret);
      } else if (error != null) {
        _showMessage("SSO Failed: $error");
      }
    }
  }

  // --------------------------------------------------------
  // EXCHANGE TOKEN WITH FRAPPE
  // --------------------------------------------------------
  Future<void> exchangeToken(String apiKey, String apiSecret) async {
    const url =
        "${ApiService.baseUrl}${ApiService.msexchangeTokenEndpoint}";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "api_key": apiKey,
        "api_secret": apiSecret,
      }),
    );

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    debugPrint("Exchange Response: $data");

    if (data["message"] != null) {
      final msg = data["message"];
      final String sid = msg["session"]["sid"];
      final String email = msg["user"];
      final String? userImage = msg["user_image"];
      final String userfullname = msg["full_name"];
      final String userType = msg["session"]["data"]["user_type"];
      String systemuser = "";

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('userfullname', userfullname ?? "");
      prefs.setString('useremail', email);
      if (userType == "System User") {
        systemuser = "yes";
      }

      Map<String, String> setCookieMap = {
        "full_name": userfullname,
        "sid": sid,
        "system_user": systemuser,
        "user_id": email,
        "user_image": userImage ?? "",
      };

      await prefs.setString("cookies", json.encode(setCookieMap));

      if (_context != null) {
        final provider = Provider.of<LoginProvider>(_context!, listen: false);

        provider.fetchEmpbyUser(email).then((value) async {
          Navigator.pushReplacement(
              _context!,
              MaterialPageRoute(builder: (_) => MainScreen()));
        });
      }
    } else {
      _showMessage("Invalid SSO Response");
    }
   }
    else {
      print("Exchange error =${response.body} ");
    }
  }

  // --------------------------------------------------------
  // UTIL: SHOW TOAST
  // --------------------------------------------------------
  void _showMessage(String msg) {
    if (_context == null) return;

    ScaffoldMessenger.of(_context!).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
