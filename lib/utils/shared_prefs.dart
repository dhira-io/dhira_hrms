import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
