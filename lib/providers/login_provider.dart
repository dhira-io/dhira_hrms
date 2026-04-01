import 'package:dhira_hrms/model/empDetails_model.dart';
import 'package:dhira_hrms/services/api_service.dart';
import 'package:dhira_hrms/utils/shared_prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _fullName;
  String? get fullName => _fullName;

  bool _isLoggingOut = false;
  bool get isLoggingOut => _isLoggingOut;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  //login
  Future<bool> signIn(String email, String password) async {
    // Clear old error
    _errorMessage = null;

    // Basic validation (you might even split validations elsewhere)
    if (email.isEmpty || !email.contains('@')) {
      _errorMessage = 'Please enter a valid email address.';
      notifyListeners();
      return false;
    }
    if (password.isEmpty || password.length < 4) {
      _errorMessage = 'Password must be at least 4 characters.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {

      final response = await ApiService.signIn(email, password);
      _fullName = response["full_name"];
      var message = response["message"];

      var loginresp = message;
      var userfullname = _fullName;

      print("login response == $response");
      print("loginresp == $loginresp");
      print("userfullname == $userfullname");

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('userfullname', userfullname ?? "");
      prefs.setString('useremail', email);

      if(loginresp != null && loginresp.contains("Logged In")) {
       return true;
      }
      else {
        print("login error = $loginresp");
        _errorMessage = loginresp ?? "Login failed";
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("login catch error = ${e.toString()}");

      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //logout
  Future<bool> logout() async {
    _isLoggingOut = true;
    notifyListeners();

    final success = await ApiService.logout();

    _isLoggingOut = false;
    notifyListeners();

    if (success) {
      await SharedPrefs.clearAll();
    }

    return success;
  }

  Future<bool> fetchEmpbyUser(userid) async {
    final prefs = await SharedPreferences.getInstance();

    notifyListeners();

      final response = await ApiService.getEmpbyUser(userid);
      final List<Data>? empdataresp = response.data;
      final String? name = empdataresp?[0].name;
      final String? employeeName = empdataresp?[0].employeeName;
      final String? department = empdataresp?[0].departmentName;
      final String? leaveapprover = empdataresp?[0].leaveapprover;

      if(leaveapprover != null) {
        final String? leaveapprovername = formatNameFromEmail(leaveapprover, capitalizeEach: true);
        prefs.setString('leaveapprovername', leaveapprovername ?? "");
        print("set leaveapprovername ==> $leaveapprovername");
      }

      prefs.setString('empid', name ?? "");
      prefs.setString('empname', employeeName ?? "");
      prefs.setString('department', department ?? "");
      prefs.setString('leaveapprover', leaveapprover ?? "");

      print("set department = $department");
    if(response.data != null) {
        return true;
      }
      else {
        return false;
      }
  }

  String formatNameFromEmail(String email, { bool capitalizeEach = false }) {
    // 1. Remove domain part (everything from '@' onward)
    final atIndex = email.indexOf('@');
    String namePart = (atIndex >= 0) ? email.substring(0, atIndex) : email;

    // 2. Replace the first dot (.) with a space
    //    If you expect only one dot between first+last name.
    namePart = namePart.replaceFirst('.', ' ');

    if (capitalizeEach) {
      // 3. Capitalize each word
      final parts = namePart.split(' ');
      final capitalized = parts.map((w) {
        if (w.isEmpty) return w;
        return w[0].toUpperCase() + w.substring(1);
      }).toList();
      namePart = capitalized.join(' ');
    }

    return namePart;
  }

}
