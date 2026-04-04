import 'package:dhira_hrms/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:dhira_hrms/features/leave/presentation/screens/leave_list_screen.dart';
import 'package:dhira_hrms/features/profile/presentation/screens/profile_screen.dart';
import 'package:dhira_hrms/features/timesheet/presentation/screens/timesheet_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/bottom_nav_cubit.dart';
import 'home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: const [
              HomeScreen(),
              AttendanceScreen(),
              TimesheetListScreen(),
              LeaveListScreen(),
              ProfileScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state,
            onTap: (index) => context.read<BottomNavCubit>().changeIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
            items: [
              BottomNavigationBarItem(icon: const Icon(Icons.home), label: l10n.home),
              BottomNavigationBarItem(icon: const Icon(Icons.timer), label: l10n.attendance),
              BottomNavigationBarItem(icon: const Icon(Icons.access_time), label: l10n.timesheet),
              BottomNavigationBarItem(icon: const Icon(Icons.calendar_month), label: l10n.leave),
              BottomNavigationBarItem(icon: const Icon(Icons.person), label: l10n.myProfile),
            ],
          );
        },
      ),
    );
  }
}


