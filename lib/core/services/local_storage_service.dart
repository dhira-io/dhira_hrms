import 'dart:convert';
import 'package:dhira_hrms/core/constants/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _themeKey = 'is_dark_mode';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // Token Management
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
  }

  // User Email Management
  Future<void> saveUserEmail(String email) async {
    await _prefs.setString(StorageConstants.userEmail, email);
  }

  String? getUserEmail() {
    return _prefs.getString(StorageConstants.userEmail);
  }

  // Employee ID Management
  String? getEmpId() {
    return _prefs.getString(StorageConstants.empId);
  }

  // User Profile Management
  String? getUserFullname() {
    return _prefs.getString(StorageConstants.userFullname);
  }

  Map<String, dynamic>? getCookieMap() {
    final cookieString = _prefs.getString(StorageConstants.cookies);
    if (cookieString != null) {
      try {
        return json.decode(cookieString) as Map<String, dynamic>;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  // Gender Management
  String? getGender() {
    return _prefs.getString(StorageConstants.gender);
  }

  // Department Management
  String? getDepartment() {
    return _prefs.getString(StorageConstants.department);
  }

  // Theme Management
  Future<void> saveThemeMode(bool isDarkMode) async {
    await _prefs.setBool(_themeKey, isDarkMode);
  }

  bool getThemeMode() {
    return _prefs.getBool(_themeKey) ?? false;
  }

  // General Clear
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
