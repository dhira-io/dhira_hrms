import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {

  final currentdatetime = DateTime.now();
  DateTime now = DateTime.now();

  static String formatDate(DateTime dt) {
    return DateFormat('yyyy-MM-dd').format(dt);
  }

  static String todayDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  static String getFirstDayOfMonth() {
    DateTime now = DateTime.now();
    DateTime firstDay = DateTime(now.year, now.month, 1);
    return DateFormat('dd-MM-yy').format(firstDay);
  }

  static String getLastDayOfMonth() {
    DateTime now = DateTime.now();
    DateTime lastDay = DateTime(now.year, now.month + 1, 0);
    return DateFormat('dd-MM-yy').format(lastDay);
  }

  static String convertDatetoTime(Datetime) {
    DateTime dt = DateTime.parse(Datetime);  // parses in UTC or local depending on format
    return DateFormat.jm().format(dt);  // “jm” gives hour:minute + AM/PM
  }

  static String getGreetingMessage() {

  int releaseTime = TimeOfDay.now().hour;
  if (releaseTime >= 0 && releaseTime <= 11) {
    return 'Hello, Good morning';
  }
  if (releaseTime > 11 && releaseTime <= 15) {
    return 'Hello, Good afternoon';
  }
  if (releaseTime > 15 && releaseTime <= 23) {
    return 'Hello, Good evening';
  }
  return 'Hello';
}

}
