import 'package:dhira_hrms/services/api_service.dart';
import 'package:flutter/material.dart';

enum ChangePasswordState { initial, loading, success, error }

class ChangePasswordProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  ChangePasswordState _state = ChangePasswordState.initial;
  String? _message;

  ChangePasswordState get state => _state;
  String? get message => _message;
  VoidCallback? _onSuccessCallback;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required VoidCallback onSuccess, // New callback function
  }) async {
    _state = ChangePasswordState.loading;
    _message = null;
    _onSuccessCallback = onSuccess;
    notifyListeners();

    try {
      await _apiService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      _state = ChangePasswordState.success;
      _message = "Password successfully updated!";
    } on Exception catch (e) {
      _state = ChangePasswordState.error;
      // Clean up the error message for display
      _message = e.toString().replaceFirst('Exception: Password change failed: Exception: ', '');
      _onSuccessCallback = null;
    }

    notifyListeners();
  }

  void resetState() {
    _state = ChangePasswordState.initial;
    _message = null;
    notifyListeners();
  }
}