import 'package:dhira_hrms/core/presentation/screens/common_web_view_screen.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_regularization_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:dhira_hrms/features/auth/presentation/screens/login_screen.dart';
import 'package:dhira_hrms/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:dhira_hrms/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:dhira_hrms/features/my_task/presentation/screens/my_task_screen.dart';
import 'package:dhira_hrms/features/organization/presentation/screens/organization_chart_screen.dart';
import 'package:dhira_hrms/features/organization/presentation/screens/organization_screen.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/team_evaluation/team_evaluation_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/team_evaluation/team_evaluation_filter_cubit.dart';
import 'package:dhira_hrms/features/splash/presentation/screens/splash_screen.dart';
import 'package:dhira_hrms/features/timesheet/presentation/screens/apply_timesheet_screen.dart';
import 'package:dhira_hrms/features/leave/presentation/screens/apply_leave_screen.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:dhira_hrms/features/profile/presentation/screens/profile_screen.dart';
import 'package:dhira_hrms/features/profile/presentation/screens/change_password_screen.dart';
import 'package:dhira_hrms/features/attendance/presentation/screens/attendance_regularization_screen.dart';
import 'package:dhira_hrms/features/notifications/presentation/screens/notifications_screen.dart';

import 'package:dhira_hrms/features/performance/presentation/screens/self_assessment_screen.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/goal_setup_page.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/team_evaluation_page.dart';
import 'package:dhira_hrms/features/performance/presentation/screens/team_evaluation_review_screen.dart';
import 'package:dhira_hrms/features/settings/presentation/bloc/notification_settings_cubit.dart';
import 'package:dhira_hrms/features/settings/presentation/screens/appearance_selection_screen.dart';
import 'package:dhira_hrms/features/settings/presentation/screens/language_selection_screen.dart';
import 'package:dhira_hrms/features/settings/presentation/screens/notification_preferences_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/features/auth/domain/repositories/auth_repository.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:flutter/material.dart';

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
  static const String attendancePath =
      '/attendance'; // For direct navigation if needed
  static const String applyLeavePath = '/apply-leave';
  static const String applyTimesheetPath = '/apply-timesheet';
  static const String myActionPath = '/myaction';
  static const String attendanceRegularizationPath =
      '/attendance-regularization';

  static const String performanceGoalSetupPath = '/performance-goal-setup';
  static const String performanceSelfAssessmentPath =
      '/performance-self-assessment';
  static const String performanceTeamEvaluationPath =
      '/performance-team-evaluation';
  static const String teamEvaluationReviewPath = '/team-evaluation-review';
  static const String notificationPreferencesPath = '/notification-preferences';
  static const String notificationsPath = '/notifications';
  static const String languageSelectionPath = '/language-selection';
  static const String appearanceSelectionPath = '/appearance-selection';
  static const String commonWebViewPath = '/webview';

  // Router Extra Keys
  static const String argEmployeeName = 'employeeName';
  static const String argEmployeeId = 'employeeId';
  static const String argDepartment = 'department';
  static const String argStatus = 'status';
  static const String argEvaluationStatus = 'evaluationStatus';
  static const String argSelfAssessmentId = 'selfAssessmentId';
  static const String argEvaluationId = 'evaluationId';
  static const String argLeave = 'leave';
  static const String argType = 'type';
  static const String argDocName = 'docname';

  // Notification Types
  static const String typeLeave = 'leave';
  static const String typeLeaveApplication = 'leave application';
  static const String typeTimesheet = 'timesheet';
  static const String typeAttendance = 'attendance';
  static const String typeAttendanceRegularization = 'attendance regularization';
  static const String typePerformance = 'performance';
  static const String typeSelfAssessment = 'self assessment';
  static const String typeRegularization = 'regularization';
  static const String typeAssessment = 'assessment';

  static void navigateByNotification({String? type, String? docName, String? title}) {
    final String normalizedType = type?.toLowerCase() ?? '';
    final String normalizedTitle = title?.toLowerCase() ?? '';

    // Check by type first
    if (normalizedType.contains(typeLeave)) {
      router.push(applyLeavePath, extra: {
        argEmployeeId: '',
        argLeave: null,
      });
      return;
    }

    if (normalizedType.contains(typeTimesheet)) {
      router.push(applyTimesheetPath, extra: docName);
      return;
    }

    if (normalizedType.contains(typeAttendance) || normalizedType.contains(typeRegularization)) {
      router.push(attendanceRegularizationPath);
      return;
    }

    if (normalizedType.contains(typePerformance) || normalizedType.contains(typeAssessment)) {
      router.push(performanceSelfAssessmentPath);
      return;
    }

    // Fallback to keyword matching in title if type is generic (like 'alert' or 'policy')
    if (normalizedTitle.contains(typeLeave)) {
      router.push(applyLeavePath, extra: {
        argEmployeeId: '',
        argLeave: null,
      });
      return;
    }

    if (normalizedTitle.contains(typeAttendance) || normalizedTitle.contains(typeRegularization)) {
      router.push(attendanceRegularizationPath);
      return;
    }

    if (normalizedTitle.contains(typeTimesheet)) {
      router.push(timesheetPath);
      return;
    }

    if (normalizedTitle.contains('task') || normalizedTitle.contains('assigned')) {
      router.push(myTaskPath);
      return;
    }

    // Default to notifications screen if no specific match found
    if (router.state?.matchedLocation != notificationsPath) {
      router.push(notificationsPath);
    }
  }

  // Routes that don't require authentication
  static const List<String> _publicRoutes = [
    splashPath,
    loginPath,
    forgotPasswordPath,
    otpVerificationPath,
  ];

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: navigatorKey,
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
        builder: (context, state) => BlocProvider.value(
          value: Get.find<TimesheetBloc>(),
          child: const ApplyTimesheetScreen(timesheetId: "current"),
        ),
      ),
      GoRoute(
        path: profilePath,
        builder: (context, state) => BlocProvider.value(
          value: Get.find<ProfileBloc>(),
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: changePasswordPath,
        builder: (context, state) => BlocProvider.value(
          value: Get.find<ProfileBloc>(),
          child: const ChangePasswordScreen(),
        ),
      ),
      GoRoute(
        path: applyLeavePath,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final employeeId = extra?[argEmployeeId] as String? ?? '';
          final leave = extra?[argLeave] as LeaveEntity?;
          return BlocProvider.value(
            value: Get.find<LeaveBloc>(),
            child: ApplyLeaveScreen(employeeId: employeeId, leave: leave),
          );
        },
      ),

      GoRoute(
        path: applyTimesheetPath,
        builder: (context, state) {
          final timesheetId = state.extra as String? ?? "0";

          return BlocProvider.value(
            value: Get.find<TimesheetBloc>(),
            child: ApplyTimesheetScreen(timesheetId: timesheetId),
          );
        },
      ),
      GoRoute(
        path: attendanceRegularizationPath,
        builder: (context, state) => BlocProvider(
          create: (context) => AttendanceRegularizationBloc(
            submitRegularizationUseCase: Get.find(),
            uploadFileUseCase: Get.find(),
            localStorageService: Get.find(),
            imageCompressService: Get.find(),
          ),
          child: const AttendanceRegularizationScreen(),
        ),
      ),

      GoRoute(
        path: performanceGoalSetupPath,
        builder: (context, state) => BlocProvider.value(
          value: Get.find<PerformanceBloc>(),
          child: const GoalSetupPage(),
        ),
      ),
      GoRoute(
        path: performanceSelfAssessmentPath,
        builder: (context, state) => const SelfAssessmentScreen(),
      ),
      GoRoute(
        path: performanceTeamEvaluationPath,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: Get.find<TeamEvaluationCubit>()),
            BlocProvider.value(value: Get.find<TeamEvaluationFilterCubit>()),
          ],
          child: const TeamEvaluationPage(),
        ),
      ),
      GoRoute(
        path: teamEvaluationReviewPath,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return TeamEvaluationReviewScreen(
            employeeName: extra[AppRouter.argEmployeeName] as String,
            employeeId: extra[AppRouter.argEmployeeId] as String,
            department: extra[AppRouter.argDepartment] as String,
            status: extra[AppRouter.argStatus] as String,
            evaluationStatus: extra[AppRouter.argEvaluationStatus] as String,
            selfAssessmentId: extra[AppRouter.argSelfAssessmentId] as String,
            evaluationId: extra[AppRouter.argEvaluationId] as String,
          );
        },
      ),

      GoRoute(
        path: notificationPreferencesPath,
        builder: (context, state) => BlocProvider.value(
          value: Get.find<NotificationSettingsCubit>(),
          child: const NotificationPreferencesScreen(),
        ),
      ),
      GoRoute(
        path: languageSelectionPath,
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: appearanceSelectionPath,
        builder: (context, state) => const AppearanceSelectionScreen(),
      ),
      GoRoute(
        path: commonWebViewPath,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          return CommonWebViewScreen(
            url: extra['url']!,
            title: extra['title']!,
          );
        },
      ),
      GoRoute(
        path: notificationsPath,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const NotificationsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
    ],
  );
}