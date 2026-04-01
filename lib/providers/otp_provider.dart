import 'package:flutter/foundation.dart';

class OtpProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _otpCode = '';
  String get otpCode => _otpCode;

  void setOtp(String value) {
    _otpCode = value;
    notifyListeners();
  }

  Future<bool> verifyOtp() async {
    if (_otpCode.length != 6) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    // Simulate API verification delay
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    // Replace this with your API response validation
    return _otpCode == "111111";
  }
}
