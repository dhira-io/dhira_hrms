import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bottom_nav_provider.dart';
import 'home_screen.dart';
import 'attendance_screen.dart';
import 'my_task_screen.dart';
import 'organization_screen.dart';

class MainScreen extends StatelessWidget {

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNav = context.watch<BottomNavProvider>();

    final List<Widget> screens = [
      HomeScreen(),
      const AttendanceScreen(),
      // const MyTaskScreen(),
      // const OrganizationScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: bottomNav.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNav.currentIndex,
        elevation: 5,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) => bottomNav.changeIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Attendance'),
          // BottomNavigationBarItem(icon: Icon(Icons.fact_check_outlined), label: 'My Task'),
          // BottomNavigationBarItem(icon: Icon(Icons.campaign_outlined), label: 'Organization'),
        ],
      ),
    );
  }
}
