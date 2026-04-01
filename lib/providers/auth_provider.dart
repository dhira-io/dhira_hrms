import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service;
  Map<String, dynamic>? _user;
  bool _isLoading = false;
  bool _isMicrosoftLogin = false;

  AuthProvider(this._service);

  Map<String, dynamic>? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get isLoading => _isLoading;
  bool get isMicrosoftLogin => _isMicrosoftLogin;

  Future<void> mslogin() async {
    _isLoading = true;
    notifyListeners();

    final userInfo = await _service.mslogin();
    if (userInfo != null) {
      _user = userInfo;
      _isMicrosoftLogin = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> mslogout() async {
    _isLoading = true;
    notifyListeners();

    if (_isMicrosoftLogin) {
      await _service.mslogout();
    }
    _user = null;
    _isMicrosoftLogin = false;

    _isLoading = false;
    notifyListeners();
  }
}
