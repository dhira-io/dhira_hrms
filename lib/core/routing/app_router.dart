import 'package:dhira_hrms/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:dhira_hrms/features/auth/presentation/screens/login_screen.dart';
import 'package:dhira_hrms/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:dhira_hrms/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:dhira_hrms/features/my_task/presentation/screens/my_task_screen.dart';
import 'package:dhira_hrms/features/organization/presentation/screens/organization_chart_screen.dart';
import 'package:dhira_hrms/features/organization/presentation/screens/organization_screen.dart';
import 'package:dhira_hrms/features/splash/presentation/screens/splash_screen.dart';
import 'package:dhira_hrms/features/timesheet/presentation/screens/apply_timesheet_screen.dart';
import 'package:dhira_hrms/features/timesheet/presentation/screens/timesheet_list_screen.dart';
import 'package:dhira_hrms/features/leave/presentation/screens/apply_leave_screen.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/screens/profile_screen.dart';
import 'package:dhira_hrms/features/profile/presentation/screens/change_password_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/dashboard/presentation/screens/my_action_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/features/auth/domain/repositories/auth_repository.dart';

class AppRouter {
  static const String splashPath = '/';
  static const String loginPath = '/login';
  static const String dashboardPath = '/dashboard';
  static const String forgotPasswordPath = '/forgot-password';
  static const String otpVerificationPath = '/otp-verification';
  static const String organizationPath = '/organization';
  static const String organizationChartPath = '/organization-chart';
  static const String myTaskPath = '/my-task';
  static const String timesheetPath = '/timesheet';
  static const String profilePath = '/profile';
  static const String changePasswordPath = '/change-password';
  static const String attendancePath = '/attendance'; // For direct navigation if needed
  static const String myActionPath = '/my-action';

  // Routes that don't require authentication
  static const List<String> _publicRoutes = [
    splashPath,
    loginPath,
    forgotPasswordPath,
    otpVerificationPath,
  ];

  static final router = GoRouter(
    initialLocation: splashPath,
    redirect: (context, state) async {
      final authRepo = Get.find<IAuthRepository>();
      final bool isAuthenticated = await authRepo.isSessionActive();
      final String location = state.matchedLocation;

      final bool isPublicRoute = _publicRoutes.contains(location);

      // If not authenticated and trying to access a protected route
      if (!isAuthenticated && !isPublicRoute) {
        return loginPath;
      }

      // If authenticated and trying to access login page
      if (isAuthenticated && location == loginPath) {
        return dashboardPath;
      }

      return null; // Allow navigation
    },
    routes: [
      GoRoute(
        path: splashPath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: dashboardPath,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: forgotPasswordPath,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: otpVerificationPath,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return OtpVerificationScreen(email: email);
        },
      ),
      GoRoute(
        path: organizationPath,
        builder: (context, state) => const OrganizationScreen(),
      ),
      GoRoute(
        path: organizationChartPath,
        builder: (context, state) => const OrganizationChartScreen(),
      ),
      GoRoute(
        path: myTaskPath,
        builder: (context, state) => const MyTaskScreen(),
      ),
      GoRoute(
        path: timesheetPath,
        builder: (context, state) => const TimesheetListScreen(),
      ),
      GoRoute(
        path: profilePath,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: changePasswordPath,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: applyLeavePath,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final employeeId = extra?['employeeId'] as String? ?? '';
          final leave = extra?['leave'] as LeaveEntity?;
          return ApplyLeaveScreen(employeeId: employeeId, leave: leave);
        },
      ),


      GoRoute(
        path: applyTimesheetPath,
        builder: (context, state) {
          final timesheetId = state.extra as String? ?? "0";

          return ApplyTimesheetScreen(
            timesheetId: timesheetId,
          );
        },
      ),
      GoRoute(
        path: myActionPath,
        builder: (context, state) => const MyActionScreen(),
      ),
    ],
  );
}
