import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_event.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/hero_section.dart';
import '../widgets/dashboard_search_bar.dart';
import '../widgets/employee_actions_section.dart';
import '../widgets/company_information_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;
  String? _role;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString(StorageConstants.userFullname) ?? "User";
      _role = "Senior Software Engineer"; // Placeholder or from storage if available
      _userId = prefs.getString(StorageConstants.userId);
    });
    if (_userId != null) {
      _refreshAll();
    }
  }

  void _refreshAll() {
    if (_userId == null) return;
    context.read<AttendanceBloc>().add(AttendanceEvent.logRequested(_userId!));
    context.read<AttendanceBloc>().add(AttendanceEvent.checkStatusRequested(_userId!));
    context.read<LeaveBloc>().add(LeaveEvent.started(_userId!));
    context.read<TimesheetBloc>().add(TimesheetEvent.started(_userId!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const DashboardHeader(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => _refreshAll(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppConstants.p16),
                      HeroSection(
                        userName: _userName ?? "User",
                        role: _role ?? "Employee",
                      ),
                      const SizedBox(height: AppConstants.p16),
                      const DashboardSearchBar(),
                      const SizedBox(height: AppConstants.p24),
                      const EmployeeActionsSection(),
                      const SizedBox(height: AppConstants.p24),
                      const CompanyInformationSection(),
                      const SizedBox(height: AppConstants.p24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

