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
  Future<void> saveEmpId(String empId) async {
    await _prefs.setString(StorageConstants.empId, empId);
  }

  String? getEmpId() {
    return _prefs.getString(StorageConstants.empId);
  }

  // User Profile Management
  Future<void> saveUserFullname(String fullname) async {
    await _prefs.setString(StorageConstants.userFullname, fullname);
  }

  String? getUserFullname() {
    return _prefs.getString(StorageConstants.userFullname);
  }

  Future<void> saveEmpName(String empName) async {
    await _prefs.setString(StorageConstants.empName, empName);
  }

  String? getEmpName() {
    return _prefs.getString(StorageConstants.empName);
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

  // Department
  Future<void> saveDepartment(String department) async {
    await _prefs.setString(StorageConstants.department, department);
  }

  String? getDepartment() {
    return _prefs.getString(StorageConstants.department);
  }

  // Approver
  Future<void> saveApprover(String approver) async {
    await _prefs.setString(StorageConstants.leaveApprover, approver);
  }

  Future<void> saveApproverName(String approverName) async {
    await _prefs.setString(StorageConstants.leaveApproverName, approverName);
  }

  String? getApprover() {
    return _prefs.getString(StorageConstants.leaveApprover);
  }

  String? getApproverName() {
    return _prefs.getString(StorageConstants.leaveApproverName);
  }

  // Gender Management
  Future<void> saveGender(String gender) async {
    await _prefs.setString(StorageConstants.gender, gender);
  }

  String? getGender() {
    return _prefs.getString(StorageConstants.gender);
  }

  // Cookie Management
  Future<void> saveCookieMap(Map<String, dynamic> cookieMap) async {
    await _prefs.setString(StorageConstants.cookies, json.encode(cookieMap));
  }

  // Theme Management
  @Deprecated('Use saveThemeModeString instead')
  Future<void> saveThemeMode(bool isDarkMode) async {
    await _prefs.setBool(_themeKey, isDarkMode);
  }

  @Deprecated('Use getThemeModeString instead')
  bool getThemeMode() {
    return _prefs.getBool(_themeKey) ?? false;
  }

  Future<void> saveThemeModeString(String mode) async {
    await _prefs.setString(_themeKey, mode);
  }

  String getThemeModeString() {
    // Fallback and migration for old bool format
    if (_prefs.containsKey(_themeKey)) {
      try {
        final isDark = _prefs.getBool(_themeKey);
        if (isDark != null) {
          return isDark ? 'dark' : 'light';
        }
      } catch (_) {
        // Not a bool, ignore
      }
    }
    return _prefs.getString(_themeKey) ?? 'system';
  }

  // FCM Token Management
  Future<void> saveFcmToken(String token) async {
    await _prefs.setString(StorageConstants.fcmToken, token);
  }

  String? getFcmToken() {
    return _prefs.getString(StorageConstants.fcmToken);
  }

  // Onboarding Status
  Future<void> saveIsFirstTime(bool isFirstTime) async {
    await _prefs.setBool(StorageConstants.isFirstTime, isFirstTime);
  }

  bool getIsFirstTime() {
    return _prefs.getBool(StorageConstants.isFirstTime) ?? true;
  }

  // Remember Me Management
  Future<void> saveRememberMe(bool value) async {
    await _prefs.setBool(StorageConstants.rememberMe, value);
  }

  bool getRememberMe() {
    return _prefs.getBool(StorageConstants.rememberMe) ?? false;
  }

  Future<void> saveRememberMeEmail(String email) async {
    await _prefs.setString(StorageConstants.rememberMeEmail, email);
  }

  String? getRememberMeEmail() {
    return _prefs.getString(StorageConstants.rememberMeEmail);
  }

  Future<void> saveRememberMePassword(String password) async {
    await _prefs.setString(StorageConstants.rememberMePassword, password);
  }

  String? getRememberMePassword() {
    return _prefs.getString(StorageConstants.rememberMePassword);
  }

  Future<void> saveRememberMeCredentials(String email, String password) async {
    await saveRememberMe(true);
    await saveRememberMeEmail(email);
    await saveRememberMePassword(password);
  }

  Future<void> clearRememberMeCredentials() async {
    await _prefs.remove(StorageConstants.rememberMe);
    await _prefs.remove(StorageConstants.rememberMeEmail);
    await _prefs.remove(StorageConstants.rememberMePassword);
  }

  // General Clear
  Future<void> clearAll() async {
    final themeModeStr = getThemeModeString();
    final fcm = getFcmToken();
    final rememberMe = getRememberMe();
    final rememberMeEmail = getRememberMeEmail();
    final rememberMePassword = getRememberMePassword();
    await _prefs.clear();
    await saveThemeModeString(themeModeStr);
    if (fcm != null) await saveFcmToken(fcm);
    // Restore remember me credentials after clear
    if (rememberMe) {
      await saveRememberMe(true);
      if (rememberMeEmail != null) await saveRememberMeEmail(rememberMeEmail);
      if (rememberMePassword != null)
        await saveRememberMePassword(rememberMePassword);
    }
  }
}
