import 'package:dhira_hrms/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:dhira_hrms/features/leave/presentation/screens/leave_list_screen.dart';
import 'package:dhira_hrms/features/profile/presentation/screens/profile_screen.dart';
import 'package:dhira_hrms/features/timesheet/presentation/screens/timesheet_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      body: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: [
              const HomeScreen(),
              const AttendanceScreen(),
              const TimesheetListScreen(),
              const LeaveListScreen(),
              const ProfileScreen(),
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
            selectedItemColor: const Color(0xff1100CC),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Attendance'),
              BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Timesheet'),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Leaves'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          );
        },
      ),
    );
  }
}
