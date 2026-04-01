import 'package:dhira_hrms/model/attendance_model.dart';
import 'package:dhira_hrms/services/api_service.dart';
import 'package:dhira_hrms/utils/toast_utils.dart';
import 'package:dhira_hrms/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AttendanceProviderStatus { Loading, Loaded, Error, Denied }

class AttendanceProvider with ChangeNotifier {

  AttendanceProviderStatus _loadingStatus = AttendanceProviderStatus.Loading;
  AttendanceProviderStatus get loadingStatus => _loadingStatus;

  bool punchedIn = false;
  bool _isPunching = false;

  String punchedIntext = "Let’s Start The Day!";
  Color buttonColor = const Color(0xFF1000CC);
  Color textColor = Colors.white;
  IconData icon = Icons.login;
  bool get isPunching => _isPunching;

  final Map<DateTime, String> _calendarMap  = {};

  int _currentYear = DateTime.now().year;
  int _currentMonth = DateTime.now().month;
  int get currentYear => _currentYear;
  int get currentMonth => _currentMonth;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Log entries
  List<LogEntry> _logs = [];

  bool _isLoadingCalendar = false;
  bool _isLoadingLogs = false;

  String? _calendarError;
  String? _logsError;
  String? _checkinError;

  // Exposed getters
  bool get isLoadingCalendar => _isLoadingCalendar;

  bool get isLoadingLogs => _isLoadingLogs;

  String? get calendarError => _calendarError;

  String? get logsError => _logsError;

  String? get checkinError => _checkinError;

  List<LogEntry> get logs => _logs;

  String? _punchError;
  String? get punchError => _punchError;

  /// Number of days in the current month
  int get daysInMonth => DateTime(currentYear, currentMonth + 1, 0).day;

  /// Get status for a day (1..daysInMonth), null if none
  String? statusForDay(int day) {
    DateTime dt = DateTime(currentYear, currentMonth, day);
    return _calendarMap[dt];
  }

  // Internal: update the currently displayed month/year
  void _updateCurrentMonth(int year, int month) {
    _currentYear = year;
    _currentMonth = month;
  }

  /// Check if a day has a status (present in JSON)
  // bool hasStatus(int day) {
  //   return statusForDay(day) != null;
  // }

  /// Fetch calendar events
  Future<void> fetchCalendar({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    _isLoadingCalendar = true;
    _calendarError = null;
    notifyListeners();

    final result = await ApiService.fetchAttendanceCalendar(
      employee: employee,
      fromDate: fromDate,
      toDate: toDate,
    );

    if (result == null) {
      _calendarError = "Failed to fetch calendar (null response)";
    } else {
      if (result.containsKey('message') && result['message'] is Map<String, dynamic>) {
        final msg = result['message'] as Map<String, dynamic>;

        _calendarMap.clear();
        msg.forEach((dtStr, st) {
          try {
            final dt = DateTime.parse(dtStr);
            final key = DateTime(dt.year, dt.month, dt.day);
            String status = st.toString().trim().toLowerCase();
            _calendarMap[key] = status;
          } catch (e) {
            // ignore parse errors or invalid dates
            print("Error parsing date in calendar: $dtStr => $e");
          }
        });
      } else {
        _calendarError = 'Invalid calendar response structure: $result';
      }
    }

    _isLoadingCalendar = false;
    notifyListeners();
  }

  /// Convenience method: fetch calendar for a given year/month
  Future<void> fetchCalendarForMonth({required String employee, required int year, required int month,}) async {
    // update our current view
    _updateCurrentMonth(year, month);

    // compute fromDate/toDate
    final DateTime from = DateTime(year, month, 1);
    final DateTime to   = DateTime(year, month + 1, 0); // last day of that month

    // You may need a date‐formatter depending on your API
    final String fromStr = Utils.formatDate(from);
    final String toStr   = Utils.formatDate(to);

    await fetchCalendar(
      employee: employee,
      fromDate: fromStr,
      toDate: toStr,
    );
  }

  /// Fetch logs (last 5 days)
  Future<void> loadlastLogs(String empid) async {
    _isLoadingLogs = true;
    _logsError = null;
    notifyListeners();

    final logsList = await ApiService.fetchLogsList(empid);
    if (logsList != null) {
      _logs = logsList;
    } else {
      _logsError = "Failed to load logs";
    }
    _isLoadingLogs = false;
    notifyListeners();
  }

  Future<bool> fetchCheckinStatus(empid) async {

    final checkinstatusresponse = await ApiService.fetchCheckinStatus(empid);
    if (checkinstatusresponse != null) {
      // Drill into the JSON to extract punched_in
      if (checkinstatusresponse.containsKey('message')) {
        final msg = checkinstatusresponse['message'];
        if (msg is Map<String, dynamic> && msg.containsKey('punched_in')) {
          final val = msg['punched_in'];
          if (val is bool) {
            punchedIn = val;
          }
        }
        // Set initial based on fetched status
        if (punchedIn) {
          punchedIntext = "That’s All For Today!";
          buttonColor = const Color(0xFFF3750B);
          icon = Icons.logout;
        } else {
          punchedIntext = "Let’s Start The Day!";
          buttonColor = const Color(0xFF1000CC);
          icon = Icons.login;
        }
      }

      // Save into SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('punched_in', punchedIn);

      _loadingStatus = AttendanceProviderStatus.Loaded;
      notifyListeners();
      return punchedIn;
    } else {
      _loadingStatus = AttendanceProviderStatus.Error;
      notifyListeners();
      return false;
    }
  }

  //punch_in
  Future<void> punchIn(String empid) async {
    _isPunching = true;
    punchedIntext = "Hang In There!";
    textColor = const Color(0xFF0B69A8);
    notifyListeners();

    final result = await ApiService.punchInAPI(empid);
    _isPunching = false;

    if (result != null &&
        result.containsKey("message") &&
        result["message"] is Map<String, dynamic>) {
      final msg = result["message"] as Map<String, dynamic>;
      bool success = msg["success"] == true;
      String successmgs = msg["message"];

      ToastMessage.showToast("$successmgs Successfully");
      if (success) {
        punchedIn = true;
        punchedIntext = "That’s All For Today!";
        buttonColor = const Color(0xFFF3750B);
        textColor = Colors.white;
        icon = Icons.logout;
      } else {
        punchedIn = false;
        punchedIntext = "Let’s Start The Day!";
        buttonColor = const Color(0xFF1000CC);
        textColor = Colors.white;
        icon = Icons.login;
      }
    } else {
      punchedIn = false;
      punchedIntext = "Let’s Start The Day!";
      buttonColor = const Color(0xFF1000CC);
      textColor = Colors.white;
      icon = Icons.login;
    }

    notifyListeners();

    // Optionally, after punching in, refresh logs / calendar
    // e.g.:
    await fetchCalendar(employee: empid,
      fromDate: Utils.getFirstDayOfMonth(),
      toDate: Utils.getLastDayOfMonth(),
    );
    await loadlastLogs(empid);
  }

  //punch_out
  Future<void> punchOut(String empid) async {
    _isPunching = true;
    punchedIntext = "Hang In There!";
    textColor = const Color(0xFF0B69A8);
    buttonColor = const Color(0xFF9FD4F8);
    notifyListeners();

    final result = await ApiService.punchOutAPI(empid);
    _isPunching = false;

    if (result != null &&
        result.containsKey("message") &&
        result["message"] is Map<String, dynamic>) {
      final msg = result["message"] as Map<String, dynamic>;
      bool success = msg["success"];
      String successmgs = msg["message"];

      ToastMessage.showToast("$successmgs Successfully");

      if (success) {
        punchedIn = false;
        punchedIntext = "Let’s Start The Day!";
        buttonColor = const Color(0xFF1000CC);
        textColor = Colors.white;
        icon = Icons.login;
      } else {
        punchedIn = true;
        punchedIntext = "That’s All For Today!";
        buttonColor = const Color(0xFFF3750B);
        textColor = Colors.white;
        icon = Icons.logout;
      }
    } else {
      punchedIn = true;
      punchedIntext = "That’s All For Today!";
      buttonColor = const Color(0xFFF3750B);
      textColor = Colors.white;
      icon = Icons.logout;
    }

    notifyListeners();

    // Optionally, after punching in, refresh logs / calendar
    // e.g.:
    await fetchCalendar(employee: empid,
      fromDate: Utils.getFirstDayOfMonth(),
      toDate: Utils.getLastDayOfMonth(),
    );
    await loadlastLogs(empid);
  }

}