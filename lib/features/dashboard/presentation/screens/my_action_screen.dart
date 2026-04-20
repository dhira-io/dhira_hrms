import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/shared/components/action_card.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyActionScreen extends StatelessWidget {
  const MyActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final actions = [
      _ActionItem(
        title: l10n.leaveRequest,
        subtitle: "Apply for leave",
        assetImagePath: "assets/icons/leave_clr.png",
        bgColor: AppColors.iconbggreen,
        route: AppRouter.leavePath,
      ),
      _ActionItem(
        title: l10n.attendanceRequest,
        subtitle: "Regularize attendance",
        assetImagePath: "assets/icons/attendance_clr.png",
        bgColor: AppColors.iconbgviolet,
        route: AppRouter.attendancePath,
      ),
      _ActionItem(
        title: l10n.timesheetRequest,
        subtitle: "Submit your hours",
        assetImagePath: "assets/icons/timesheet_clr.png",
        bgColor: AppColors.iconbgblue,
        route: AppRouter.timesheetPath,
      ),
      _ActionItem(
        title: l10n.comOff,
        subtitle: "Compensatory off",
        assetImagePath: "assets/icons/leave_clr.png", // Reusing leave icon as placeholder
        bgColor: AppColors.iconbgred,
        route: null, // Placeholder
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          l10n.myAction,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.1,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final item = actions[index];
            return ActionCard(
              title: item.title,
              subtitle: item.subtitle,
              assetImagePath: item.assetImagePath,
              bgColor: item.bgColor,
              onTap: () {
                if (item.route == AppRouter.attendancePath) {
                  context.read<BottomNavCubit>().changeIndex(1);
                  // Since we are in a sub-screen, we might want to pop or just let it handle
                  // Navigator.of(context).pop(); 
                } else if (item.route != null) {
                  context.push(item.route!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${item.title} feature coming soon!")),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class _ActionItem {
  final String title;
  final String subtitle;
  final String assetImagePath;
  final Color bgColor;
  final String? route;

  _ActionItem({
    required this.title,
    required this.subtitle,
    required this.assetImagePath,
    required this.bgColor,
    this.route,
  });
}
