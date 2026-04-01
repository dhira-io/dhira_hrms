import 'dart:convert';

import 'package:dhira_hrms/model/leave_list_model.dart';
import 'package:dhira_hrms/model/leave_type_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/singleLeave_model.dart';
import '../services/api_service.dart';

class LeaveProvider extends ChangeNotifier {
  List<LeaveListModel> _allItems = [];
  List<LeaveListModel> _filteredItems = [];
  String _searchQuery = '';

  // read‑only employee details
  String employeeName = '';
  String department = '';
  String approver = '';
  String employeeId = '';

  Data? leaveData;

  // form fields
  DateTime? fromDate;
  DateTime? toDate;
  int isHalfDay = 0;
  DateTime? halfDayDate;
  String leaveType = '';
  String reason = '';

  // summary data
  int totalAllocated = 0;
  int used = 0;
  int pending = 0;
  int get available => totalAllocated - used - pending;

  // status
  bool isLoading = false;
  String? errorMessage;
  bool success = false;
  bool isFetchingMore = false;   // loading next pages
  bool hasMoreData = true;       // whether more pages exist

  int _start = 0;
  final int _length = 5;

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  String? _updateError;
  String? get updateError => _updateError;

  List<LeaveTypeItemModel> leaveTypes = [];
  bool isLeaveTypesLoading = false;

  final ApiService _apiService = ApiService();

  LeaveProvider() {
    _loadEmployeeDetails();
    _loadSummary();
    loadLeaveTypes();
    _filteredItems = [];

  }

  List<LeaveListModel> get items => _filteredItems;

  Future<void> _loadEmployeeDetails() async {
    final prefs = await SharedPreferences.getInstance();
    employeeName = prefs.getString('userfullname') ?? '';
    department = prefs.getString('department') ?? 'data & analysis';
    approver = prefs.getString('approver') ?? '';
    employeeId = prefs.getString('empid') ?? '';
    notifyListeners();
  }

  Future<void> _loadSummary() async {
    final prefs = await SharedPreferences.getInstance();
    totalAllocated = prefs.getInt('totalAllocated') ?? 0;
    used = prefs.getInt('used') ?? 0;
    pending = prefs.getInt('pending') ?? 0;
    notifyListeners();
  }

  void resetFormFields() {
    fromDate = null;
    toDate = null;
    isHalfDay = 0;
    halfDayDate = null;
    leaveType = '';
    reason = '';
    leaveData = null;
    errorMessage = null;
    success = false;
    _start           = 0;
    _searchQuery     = '';

    notifyListeners();
  }

  void setFromDate(DateTime val) {
    fromDate = val;
    if (toDate != null && toDate!.isBefore(fromDate!)) {
      toDate = fromDate;
    }
    notifyListeners();
  }

  void setToDate(DateTime val) {
    toDate = val;
    notifyListeners();
  }

  void setHalfDay(int val) {
    isHalfDay = val;
    if (isHalfDay == 0) {
      halfDayDate = null;
    }
    notifyListeners();
  }

  void setHalfDayDate(DateTime? val) {
    halfDayDate = val;
    notifyListeners();
  }

  void setLeaveType(String val) {
    leaveType = val;
    notifyListeners();
  }

  void setReason(String val) {
    reason = val;
    notifyListeners();
  }

  //leave list
  Future<void> loadLeaveApplications({bool refresh = false}) async {
    if (isLoading || isFetchingMore) return;

    if (refresh) {
      // reset state for fresh load
      _start = 0;
      hasMoreData = true;
      _allItems.clear();
      errorMessage = null;
    }

    if (!hasMoreData) {
      // no more data to fetch
      return;
    }

    if (_start == 0) {
      isLoading = true;
    } else {
      isFetchingMore = true;
    }

    notifyListeners();

    try {
      final newItems = await _apiService.fetchLeaveApplicationsList(
        start: _start,
        length: _length,
      );

      if (newItems.isEmpty) {
        // no items returned -> no more pages
        hasMoreData = false;
      } else {
        _allItems.addAll(newItems);
        _start += _length;
      }

      applySearch(_searchQuery, notify: false);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      isFetchingMore = false;
      notifyListeners();
    }
  }

  // Optional: a method to clear/reset provider (if user logs out etc)
  void reset() {
    _allItems        = [];
    _filteredItems   = [];
    isLoading = false;
    isFetchingMore = false;
    hasMoreData = true;
    errorMessage = null;
    _start = 0;
    _searchQuery = '';
    notifyListeners();
  }

  Future<void> searchLeaves(String query) async {
    // If you support server side search
    _searchQuery = query;
    _start       = 0;
    hasMoreData  = true;
    _allItems.clear();
    notifyListeners();
    await loadLeaveApplications(refresh: true);
  }

  //leave type
  Future<void> loadLeaveTypes() async {
    isLeaveTypesLoading = true;
    notifyListeners();
    try {
      leaveTypes = await _apiService.fetchLeaveTypes();

      // If you want to default to “Vacation” if present:
      // final vacation = leaveTypes.firstWhere(
      //         (item) => item.leaveTypeName == 'Vacation',
      //     orElse: () => leaveTypes.isNotEmpty ? leaveTypes.first : LeaveTypeItemModel(name: '', leaveTypeName: '')
      // );
      leaveType = "Vacation"; //vacation.leaveTypeName;
      /* //show all list
     if(leaveTypes.isNotEmpty) {
        leaveType = leaveTypes.first.leaveTypeName;
      }*/
      // print("Lev type =======> $leaveType");
      notifyListeners();
    } catch (e) {
      // handle error (set errorMessage, etc)
      errorMessage = 'Failed to load leave types';
      notifyListeners();
    } finally {
      isLeaveTypesLoading = false;
      notifyListeners();
    }
  }

  Future<void> submit() async {
    // validation
    if (employeeId.isEmpty) {
      errorMessage = 'Employee ID missing';
      notifyListeners();
      return;
    }
    if (leaveType.isEmpty) {
      errorMessage = 'Please select leave type';
      notifyListeners();
      return;
    }
    if (isHalfDay == 1) {
      if (halfDayDate == null) {
        errorMessage = 'Please select the half‑day date';
        notifyListeners();
        return;
      }
    } else {
      if (fromDate == null || toDate == null) {
        errorMessage = 'Please select from and to dates';
        notifyListeners();
        return;
      }
    }

    isLoading = true;
    errorMessage = null;
    success = false;
    notifyListeners();

    try {
    final String fromStr = fromDate!
        .toIso8601String()
        .split('T')
        .first;
    final String toStr = toDate!
        .toIso8601String()
        .split('T')
        .first;
    final String? halfDayStr = isHalfDay == 1 ? halfDayDate!
        .toIso8601String()
        .split('T')
        .first : null;


    final resp = await _apiService.submitLeaveApplication(
      employeeId: employeeId,
      leaveType: leaveType,
      fromDate: fromStr,
      toDate: toStr,
      reason: reason,
      halfDay: isHalfDay,
      halfDayDate: halfDayStr,
    );

    print(
        "leave employeeId ==> $employeeId\nleaveType=$leaveType,\nfromStr=$fromStr,\ntoStr=$toStr,\nreason=$reason,\nisHalfDay=$isHalfDay,\nhalfDayStr=$halfDayStr");

    print("leave statusCode === ${resp.statusCode}");

    if (resp.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(resp.body);
      final messageObj = jsonMap['message'] as Map<String, dynamic>;
      final bool statussuccess = messageObj['success'] as bool;
      if(statussuccess) {
        success = true;
      }
      else {
        final nestedMsgObj = messageObj['message'] as Map<String, dynamic>;
        final String errorMsg = nestedMsgObj['message'] as String;

        // Remove HTML tags to get only: “Employee HR-EMP-00055 has already applied for Vacation between 03-11-2025 and 03-11-2025”
        errorMessage = errorMsg.replaceAll(RegExp(r'<[^>]*>'), '');
      }
      print("leave == ${resp.body}");
    } else {
      errorMessage = 'Submission failed: ${resp.statusCode}';
    }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //single leave
  Future<void> fetchSingleLeave(String leaveId) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.fetchSingleLeave(leaveId);
      leaveData = result?.data;
      if (leaveData == null) {
        debugPrint("⚠️ No data found for timesheet $leaveId");
        return;
      }
      else {
        fromDate = DateTime.parse(leaveData!.fromDate ?? "");
        toDate = DateTime.parse(leaveData!.toDate ?? "");
        isHalfDay = (leaveData!.halfDay ?? 0);
        if (isHalfDay == 1 && leaveData!.halfDayDate != null) {
          halfDayDate = DateTime.parse(leaveData!.halfDayDate!);
        }
        leaveType = leaveData!.leaveType ?? "";
        reason = leaveData!.description ?? "";

        notifyListeners();

      }
    } catch (e) {
      debugPrint("Error fetching single leave: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //delete leave
  Future<void> deleteLeave(String name) async {
    try {
      await _apiService.deleteLeaveApplication(name);
      // After deletion, refresh from the start
      await loadLeaveApplications(refresh: true);
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  //cancel leave
  Future<void> cancelLeave(String name) async {
    try {
      await _apiService.cancelLeaveApplication(name);
      // After cancellation, refresh from the start
      await loadLeaveApplications(refresh: true);
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> updateLeave(String leaveId) async {
    if (employeeId.isEmpty) {
      errorMessage = 'Employee ID missing';
      notifyListeners();
      return;
    }
    if (leaveType.isEmpty) {
      errorMessage = 'Please select leave type';
      notifyListeners();
      return;
    }
    if (isHalfDay == 1) {
      if (halfDayDate == null) {
        errorMessage = 'Please select the half-day date';
        notifyListeners();
        return;
      }
    } else {
      if (fromDate == null || toDate == null) {
        errorMessage = 'Please select from and to dates';
        notifyListeners();
        return;
      }
    }

    isLoading = true;
    errorMessage = null;
    success = false;
    notifyListeners();

    try {
      final String fromStr = fromDate!.toIso8601String().split('T').first;
      final String toStr   = toDate!.toIso8601String().split('T').first;
      final String? halfDayStr = isHalfDay == 1 ? halfDayDate!.toIso8601String().split('T').first : null;

      final resp = await _apiService.updateLeaveApplication(
        leaveId:    leaveId,
        fromDate:   fromStr,
        toDate:     toStr,
        reason:     reason,
        halfDay:    isHalfDay,
        halfDayDate: halfDayStr,
      );

      if (resp.statusCode == 200) {
        success = true;
      } else {
        errorMessage = 'Update leave failed: ${resp.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Error updating leave: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeLeaveStatus({
    required String leaveApplicationName,
    required String newStatus,
    required VoidCallback onSuccess,
  }) async {
    _isUpdating = true;
    _updateError = null;
    notifyListeners();

    try {
      final bool success = await ApiService.updateLeaveApplicationStatus(
        leaveApplicationName: leaveApplicationName,
        newStatus: newStatus,
      );

      if (success) {
        onSuccess();
      } else {
        _updateError = 'Failed to update status';
      }
    } catch(e) {
      _updateError = e.toString();
    }

    _isUpdating = false;
    notifyListeners();
  }

  void applySearch(String query, { bool notify = true }) {
    _searchQuery = query;
    if (query.trim().isEmpty) {
      _filteredItems = List.from(_allItems);
    } else {
      final lower = query.toLowerCase();
      _filteredItems = _allItems.where((leave) {
        return leave.name.toLowerCase().contains(lower)
            || leave.employee.toLowerCase().contains(lower)
            || leave.leaveType.toLowerCase().contains(lower)
            || leave.status.toLowerCase().contains(lower)
            || leave.leaveapprover!.toLowerCase().contains(lower);
      }).toList();
    }
    if (notify) notifyListeners();
  }

  Future<void> getLeaveBalanceAPI(String? employeeID, String? todaydate) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.getLeaveBalance(employeeId,todaydate);

      if (!response.containsKey('message')) {
        throw Exception('Invalid response: missing "message" key');
      }

      final message = response['message'] as Map<String, dynamic>;

      final allocations =
      message['leave_allocation'] as Map<String, dynamic>;

      if (allocations.containsKey('Vacation')) {
        final vac = allocations['Vacation'] as Map<String, dynamic>;
        totalAllocated = (vac['total_leaves'] as num).toInt();
        used           = (vac['leaves_taken'] as num).toInt();
        pending        = (vac['leaves_pending_approval'] as num).toInt();

        print("getLeaveBalance ==> $totalAllocated\nused=$used\npending=$pending");

        notifyListeners();

      } else {
        // handle no “Vacation” key
        totalAllocated = 0;
        used           = 0;
        pending        = 0;
      }
    } catch (e) {
      errorMessage = e.toString();
      totalAllocated = 0;
      used           = 0;
      pending        = 0;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}