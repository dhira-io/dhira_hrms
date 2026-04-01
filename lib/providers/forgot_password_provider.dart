// lib/providers/forgot_password_provider.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';

enum ForgotPasswordState { initial, loading, success, error }

class ForgotPasswordProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  ForgotPasswordState _state = ForgotPasswordState.initial;
  String? _message;

  ForgotPasswordState get state => _state;
  String? get message => _message;

  Future<void> forgotPasswordEmail(String email) async {
    _state = ForgotPasswordState.loading;
    _message = null;
    notifyListeners();

    try {
      final apiMessage = await _apiService.forgotPasswordResetEmail(email);
      _state = ForgotPasswordState.success;
      _message = apiMessage;
    } on Exception catch (e) {
      _state = ForgotPasswordState.error;
      _message = e.toString();
    }

    notifyListeners();
  }

  void resetState() {
    _state = ForgotPasswordState.initial;
    _message = null;
    notifyListeners();
  }
}
