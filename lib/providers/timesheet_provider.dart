import 'package:dhira_hrms/model/projectname_model.dart';
import 'package:dhira_hrms/model/singleTimesheet_model.dart';
import 'package:dhira_hrms/model/timesheet_list_model.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TimesheetProvider with ChangeNotifier {
  List<TimesheetListModel> _timesheets = [];
  List<ProjectNameModel> _projects = [];
  List<ProjectAssignments> projectAssignments = [];
  List<TimesheetListModel> _filteredTimesheets = [];
  List<TimesheetListModel> get filteredTimesheets => _filteredTimesheets;

  // local assignments used while editing/applying on the screen
  List<ProjectAssignments> localAssignments = [];

  Data? timesheetData;
  String? _selectedProject;
  bool _isLoadingTimesheets = false;
  bool isLoadingProjects = false;
  bool _isLoading = false;
  int _currentStart = 0;
  final int _limit = 5;
  bool _hasMore = true;
  String? _errorMessage;
  String? _paginationErrorMessage;   // error during load more
  String _searchQuery = '';
  // summary fields (these are the ones the UI will read)
  double totalHours = 0.0;
  double expectedHours = 0.0;
  double spentHours = 0.0;
  double remainingHours = 0.0;

  DateTime _selectedDate = DateTime.now();

  List<ProjectNameModel> get projects => _projects;
  String? get selectedProject => _selectedProject;
  DateTime get selectedDate => _selectedDate;

  bool get isLoadingTimesheets => _isLoadingTimesheets;
  List<TimesheetListModel> get timesheets => _timesheets;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get errorMessage => _errorMessage;
  String? get paginationErrorMessage => _paginationErrorMessage;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  // read‑only employee details
  String employeeId = '';
  String employeeName = '';
  String department = '';
  String approver = '';

  // form fields
  DateTime? fromDate;
  DateTime? toDate;

  // --- Set Dates ---
  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  // --- Set Hours ---
  void setExpectedHours(double hours) {
    expectedHours = hours;
    notifyListeners();
  }

  void setSpentHours(double hours) {
    spentHours = hours;
    notifyListeners();
  }

  /// Call to set search query and update filtered list
  void setSearchQuery(String query) {
    _searchQuery = query.trim().toLowerCase();
    _updateFilter();
  }

  void clearSearch() {
    _searchQuery = '';
    _updateFilter();
  }

  void _updateFilter() {
    if (_searchQuery.isEmpty) {
      _filteredTimesheets = List<TimesheetListModel>.from(_timesheets);
    } else {
      _filteredTimesheets = _timesheets.where((item) {
        final nameMatch = item.employee.toLowerCase().contains(_searchQuery);
        final idMatch   = item.name.toLowerCase().contains(_searchQuery);
        final statusText = (item.docStatus == 0 ? 'draft' : 'saved');
        final statusMatch = statusText.toLowerCase().contains(_searchQuery);
        final approverMatch   = item.approver.toLowerCase().contains(_searchQuery);
        final fromDateMatch   = item.fromDate.toLowerCase().contains(_searchQuery);
        final toDateMatch   = item.fromDate.toLowerCase().contains(_searchQuery);

        return nameMatch || idMatch || statusMatch || approverMatch || fromDateMatch || toDateMatch;
      }).toList();
    }
    notifyListeners();
  }

  /// Recalculate summary from `localAssignments`.
  void calculateSummary() {
    double expected = 0.0;
    double spent = 0.0;

    for (final a in localAssignments) {
      expected += a.expectedHours ?? 0.0;
      spent += a.spentHours ?? 0.0;
    }

    expectedHours = expected;
    spentHours = spent.clamp(0.0, double.infinity);
    // hours total can mean different things depending on your domain.
    // I'll set hoursTotal = spentHoursTotal (so total spent is visible).
    totalHours = 48.0;
    remainingHours = (expectedHours - spentHours).clamp(0.0, double.infinity);

    notifyListeners();
  }

  /// Set summary values coming from the server (when editing / after API response)
  void setSummaryFromServer({
    double? hours_total,
    double? expected_hours_total,
    double? spent_hours,
    double? remaining_hours,
  }) {
    totalHours = hours_total ?? 48.0;
    expectedHours = expected_hours_total ?? 0.0;
    spentHours = spent_hours?.clamp(0.0, double.infinity) ?? 0.0;
    remainingHours = (expectedHours - spentHours).clamp(0.0, double.infinity);
    notifyListeners();
  }

  // --- local assignment operations (keeps provider and UI in sync) ----------
  void setLocalAssignments(List<ProjectAssignments> assignments) {
    localAssignments = List<ProjectAssignments>.from(assignments);
    calculateSummary();
  }

  //project assignments
  void addLocalAssignment(ProjectAssignments a) {
    localAssignments.add(a);
    // optionally reflect in timesheetData if editing
    timesheetData?.projectAssignments ??= [];
    timesheetData?.projectAssignments?.add(a);
    calculateSummary();
  }

  void updateLocalAssignment(int index, ProjectAssignments a) {
    if (index >= 0 && index < localAssignments.length) {
      localAssignments[index] = a;
      if (timesheetData?.projectAssignments != null && index < (timesheetData!.projectAssignments!.length)) {
        timesheetData!.projectAssignments![index] = a;
      }
      calculateSummary();
    }
  }

  void deleteLocalAssignment(int index) {
    if (index >= 0 && index < localAssignments.length) {
      localAssignments.removeAt(index);
      if (timesheetData?.projectAssignments != null && index < (timesheetData!.projectAssignments!.length)) {
        timesheetData!.projectAssignments!.removeAt(index);
      }
      calculateSummary();
    }
  }

  Future<void> fetchSingleTimesheets(String timesheetId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result  = await ApiService.fetchSingleTimesheets(timesheetId);

      timesheetData = result?.data;
      if (timesheetData != null) {
        // load assignments from server
        final serverAssignments = timesheetData?.projectAssignments ?? [];
        localAssignments = List<ProjectAssignments>.from(serverAssignments);

        // if server gives summary fields, use them; otherwise calculate from assignments
        if ((timesheetData?.hoursTotal != null) ||
            (timesheetData?.expectedHoursTotal != null) ||
            (timesheetData?.remainingHours != null)) {

          setSummaryFromServer(
            hours_total: timesheetData?.hoursTotal ?? 48.0,
            expected_hours_total: timesheetData?.expectedHoursTotal ?? 0.0,
            remaining_hours: timesheetData?.remainingHours ?? 0.0,
            spent_hours: timesheetData?.totalSpentHours ?? 0.0,
          );
        } else {
          // fallback: calculate locally from assignments
          calculateSummary();
        }
      } else {
        // no data, reset
        timesheetData = null;
        localAssignments = [];
        setSummaryFromServer(hours_total: 0.0, expected_hours_total: 0.0, spent_hours: 0.0, remaining_hours: 0.0);
      }
    } catch (e) {
      debugPrint("Error fetching single timesheet: $e");
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //timesheet list
  Future<void> fetchTimesheets({bool refresh = false}) async {
    // Prevent duplicate loading
    if (_isLoadingTimesheets) return;

    try {
      _isLoadingTimesheets = true;
      _paginationErrorMessage = null;
      _errorMessage = null;
      notifyListeners();

      if (refresh) {
      _currentStart = 0;
      _hasMore = true;
      _timesheets.clear();
    }

    // Stop if all data already loaded
    if (!hasMore) return;

      final newItems = await ApiService.fetchTimesheets(
        start: _currentStart,
        limit: _limit,
      );

      if (refresh && newItems.isEmpty) {
        _timesheets.clear();
        _hasMore = false;
      }
      else if (newItems.isEmpty) {
        _hasMore = false;
      }
      else {
        _currentStart += newItems.length;
        _timesheets.addAll(newItems);
      }
    } catch (e) {
      if (_currentStart == 0) {
        // initial load failed
        _filteredTimesheets = [];
       // _errorMessage = e.toString();
      } else {
        // pagination (load more) failed
        _paginationErrorMessage = e.toString();
      }
    } finally {
      _isLoadingTimesheets = false;
      _updateFilter();
      notifyListeners();
    }
  }

  /// ✅ Submit / Update API Calls
  Future<bool> submitTimesheet({
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required List<ProjectAssignments> assignments,
    required BuildContext context,
  }) async {
    // isSubmitting = true;
    notifyListeners();

    final payload = {
      "employee": employee,
      "organization_department": department,
      "approver": approver,
      "from_date": fromDate,
      "to_date": toDate,
      "project_assignments": assignments.map((a) => a.toJson()).toList(),
    };

    print("create payload ==> $payload");

    final success = await ApiService.createTimesheet(context, payload);
    if (success == true) {
      // optimistic: set local summary based on assignments
      calculateSummary();

      // try to refresh server values: fetch list and try to find created
      try {
        await fetchTimesheets(refresh: true);
        // find by employee + from + to
        final match = _timesheets.firstWhere(
              (t) => t.employee == employee && t.fromDate == fromDate && t.toDate == toDate,
          orElse: () => null as TimesheetListModel,
        );
        if (match != null) {
          // if we found the created timesheet, fetch its details
          await fetchSingleTimesheets(match.name);
        }
      } catch (e) {
        debugPrint("Could not refresh created timesheet: $e");
      }

      _isSubmitting = false;
      notifyListeners();
      return true;
    } else {
      _isSubmitting = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTimesheet({
    required String name,
    required String employee,
    required String department,
    required String approver,
    required int approved,
    required double hours_total,
    required List<ProjectAssignments> assignments,
    required BuildContext context,  // Accept context
  }) async {
    // isSubmitting = true;
    notifyListeners();

    final payload = {
      "name": name,
      "employee": employee,
      "organization_department": department,
      "approver": approver,
      "approved": approved,
      "hours_total": hours_total,
      "project_assignments": assignments.map((a) => a.toJson()).toList(),
    };

    print("updateTimesheet payload ==> $payload");

    final success = await ApiService.updateTimesheet(context, payload);
    if (success == true) {
      // After successful update, fetch single timesheet again to get server summary
      await fetchSingleTimesheets(name);

      // _isSubmitting = false;
      notifyListeners();
      return true;
    } else {
      // _isSubmitting = false;
      notifyListeners();
      return false;
    }
 }

//project name
  Future<void> fetchProjects() async {
    isLoadingProjects  = true;
    notifyListeners();
    try {
      _projects = await ApiService.fetchProjects();
    } catch (e) {
      debugPrint("Error fetching projects: $e");
    } finally {
      isLoadingProjects  = false;
      notifyListeners();
    }
  }

  /// Retry loading more timesheets (after pagination error)
  Future<void> retryLoadMore() async {
    if (!isLoadingTimesheets && hasMore) {
      _paginationErrorMessage = null;
      notifyListeners();
      await fetchTimesheets();
    }
  }

  /// Clear all local data (for logout or global refresh)
  void clearTimesheets() {
    _timesheets.clear();
    _currentStart = 0;
    _hasMore = true;
    _errorMessage = null;
    _paginationErrorMessage = null;
    notifyListeners();
  }

  // helpers
  void clearLocalData() {
    localAssignments.clear();
    timesheetData = null;
    setSummaryFromServer(hours_total: 0.0, expected_hours_total: 0.0, spent_hours: 0.0, remaining_hours: 0.0);
  }

  Future<void> fetchTimesheetApprover(String employeeId) async {
    _isLoading = true;
    notifyListeners();

    final response = await ApiService.getUserForApprover(employeeId);

    if (response != null && response['message'] != null) {
      var timesheetapproverName = response['message'].toString();
      print("timesheetapproverName message : $timesheetapproverName");
    } else {
      var timesheetapproverName = "No data found";
    }

    _isLoading = false;
    notifyListeners();
  }

}
