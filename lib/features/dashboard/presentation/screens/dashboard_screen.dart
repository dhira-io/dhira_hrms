import 'package:dhira_hrms/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/bottom_nav_cubit.dart';
import 'home_screen.dart';

import 'package:get/get.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavCubit>.value(value: Get.find<BottomNavCubit>()),
        BlocProvider<DashboardCubit>.value(value: Get.find<DashboardCubit>()),
        BlocProvider<AttendanceBloc>.value(value: Get.find<AttendanceBloc>()),
        BlocProvider<LeaveBloc>.value(value: Get.find<LeaveBloc>()),
        BlocProvider<TimesheetBloc>.value(value: Get.find<TimesheetBloc>()),
      ],
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
      body: SafeArea(
        child: BlocBuilder<BottomNavCubit, int>(
          builder: (context, state) {
            return IndexedStack(
              index: state,
              children: const [
                HomeScreen(),
                AttendanceScreen(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state,
            onTap: (index) => context.read<BottomNavCubit>().changeIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryBlue,
            unselectedItemColor: AppColors.textSecondary,
            items: [
              BottomNavigationBarItem(icon: const Icon(Icons.home), label: l10n.home),
              BottomNavigationBarItem(icon: const Icon(Icons.access_time), label: l10n.attendance),
            ],
          );
        },
      ),
    );
  }
}


