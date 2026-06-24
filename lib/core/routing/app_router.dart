import 'package:dhira_hrms/core/presentation/screens/common_web_view_screen.dart';
import 'package:dhira_hrms/features/notifications/data/constants/notification_constants.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_regularization_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:dhira_hrms/features/auth/presentation/screens/login_screen.dart';
import 'package:dhira_hrms/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:dhira_hrms/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:dhira_hrms/features/my_task/presentation/screens/my_task_screen.dart';
import 'package:dhira_hrms/features/organization/presentation/screens/organization_chart_screen.dart';
import 'package:dhira_hrms/features/organization/presentation/screens/organization_screen.dart';
import 'package:dhira_hrms/features/auth/presentation/screens/auth_callback_screen.dart'
    as dhira_auth_callback;
import 'package:dhira_hrms/features/payslip/presentation/bloc/payslip_bloc.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/features/payslip/presentation/screens/payslip_detail_screen.dart';
import 'package:dhira_hrms/features/payslip/presentation/screens/payslip_list_screen.dart';
import 'package:dhira_hrms/features/policy/presentation/bloc/policy_bloc.dart';
import 'package:dhira_hrms/features/policy/presentation/bloc/policy_event.dart';
import 'package:dhira_hrms/features/policy/presentation/screens/policy_screen.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_event.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/team_evaluation/team_evaluation_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/team_evaluation/team_evaluation_filter_cubit.dart';
import 'package:dhira_hrms/features/splash/presentation/screens/splash_screen.dart';
import 'package:dhira_hrms/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:dhira_hrms/features/onboarding/presentation/screens/get_started_screen.dart';
import 'package:dhira_hrms/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:dhira_hrms/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:dhira_hrms/features/settings/presentation/screens/settings_screen.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/screens/apply_timesheet_screen.dart';
import 'package:dhira_hrms/features/leave/presentation/screens/apply_leave_screen.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:dhira_hrms/features/profile/presentation/screens/profile_screen.dart';
import 'package:dhira_hrms/features/profile/presentation/screens/change_password_screen.dart';
import 'package:dhira_hrms/features/attendance/presentation/screens/attendance_regularization_screen.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_bloc.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/screens/compensatory_leave_screen.dart';
import 'package:dhira_hrms/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:dhira_hrms/core/widgets/coming_soon_screen.dart';

import 'package:dhira_hrms/features/performance/presentation/screens/self_assessment_screen.dart';
import 'package:dhira_hrms/features/performance/presentation/screens/performance_dashboard_screen.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/goal_setup_page.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/team_evaluation_page.dart';
import 'package:dhira_hrms/features/performance/presentation/screens/team_evaluation_review_screen.dart';
import 'package:dhira_hrms/features/settings/presentation/bloc/notification_settings_cubit.dart';
import 'package:dhira_hrms/features/settings/presentation/screens/appearance_selection_screen.dart';
import 'package:dhira_hrms/features/settings/presentation/screens/language_selection_screen.dart';
import 'package:dhira_hrms/features/settings/presentation/screens/notification_preferences_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/usecases/get_approvals_access_usecase.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:go_router/go_router.dart';
import 'package:dhira_hrms/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String splashPath = '/';
  static const String welcomePath = '/welcome';
  static const String getStartedPath = '/get-started';
  static const String onboardingPath = '/onboarding';
  static const String loginPath = '/login';
  static const String dashboardPath = '/dashboard';
  static const String authCallbackPath = '/auth/callback';
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
  static const String compensatoryLeavePath = '/compensatory-leave';

  static const String performanceDashboardPath = '/performance-dashboard';
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
  static const String payslipPath = '/payslip';
  static const String payslipDetailPath = '/payslip-detail';
  static const String settingsPath = '/settings';
  static const String comingSoonPath = '/coming-soon';
  static const String policyPath = '/policy';

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
  static const String typeAttendanceRegularization =
      'attendance regularization';
  static const String typePerformance = 'performance';
  static const String typeSelfAssessment = 'self assessment';
  static const String typeRegularization = 'regularization';
  static const String typeAssessment = 'assessment';
  static const String typeCompensatory = 'compensatory';

  static Future<void> _navigateToApprovals(ApprovalType type) async {
    try {
      final getAccess = Get.find<GetApprovalsAccessUseCase>();
      final accessResult = await getAccess();
      final bool isManager = accessResult.fold(
        (_) => false,
        (access) => access.canAccess,
      );

      final category = isManager
          ? ApprovalCategory.team
          : ApprovalCategory.raised;

      Get.find<ApprovalsBloc>().add(
        ApprovalsEvent.categoryChanged(type, category),
      );

      Get.find<BottomNavCubit>().changeIndex(BottomNavCubit.approvalsIndex);
      router.go(dashboardPath);
    } catch (e) {
      router.go(dashboardPath);
    }
  }

  static void navigateToRaisedRequests(ApprovalType type) {
    try {
      Get.find<ApprovalsBloc>().add(
        ApprovalsEvent.categoryChanged(type, ApprovalCategory.raised),
      );
      Get.find<BottomNavCubit>().changeIndex(BottomNavCubit.approvalsIndex);
      router.go(dashboardPath);
    } catch (e) {
      router.go(dashboardPath);
    }
  }

  static void navigateByNotification({
    String? type,
    String? docName,
    String? title,
  }) {
    final String normalizedType = type?.toLowerCase() ?? '';
    final String normalizedTitle = title?.toLowerCase() ?? '';

    // Check for compensatory leave first (before generic leave, since compOff
    // doctype is 'Compensatory Leave Request' which also contains 'leave')
    if (normalizedType.contains(typeCompensatory) ||
        normalizedTitle.contains(typeCompensatory)) {
      _navigateToApprovals(ApprovalType.compOff);
      return;
    }

    // Check by type first (handles leave, leave_application, leave application, etc.)
    if (normalizedType.contains(typeLeave)) {
      _navigateToApprovals(ApprovalType.leave);
      return;
    }

    if (normalizedType.contains(typeTimesheet)) {
      _navigateToApprovals(ApprovalType.timesheet);
      return;
    }

    if (normalizedType.contains(typeAttendance) ||
        normalizedType.contains(typeRegularization)) {
      _navigateToApprovals(ApprovalType.attendance);
      return;
    }

    if (normalizedType.contains(typePerformance) ||
        normalizedType.contains(typeAssessment)) {
      router.push(performanceSelfAssessmentPath);
      return;
    }

    // Fallback to keyword matching in title if type is generic (like 'alert' or 'policy')
    if (normalizedTitle.contains(typeLeave)) {
      _navigateToApprovals(ApprovalType.leave);
      return;
    }

    if (normalizedTitle.contains(typeAttendance) ||
        normalizedTitle.contains(typeRegularization)) {
      _navigateToApprovals(ApprovalType.attendance);
      return;
    }

    if (normalizedTitle.contains(typeTimesheet)) {
      _navigateToApprovals(ApprovalType.timesheet);
      return;
    }

    if (normalizedTitle.contains('task') ||
        normalizedTitle.contains('assigned')) {
      router.push(myTaskPath);
      return;
    }

    // Default to notifications screen if no specific match found
    if (router.state?.matchedLocation != notificationsPath) {
      router.push(notificationsPath);
    }
  }

  static void navigateByMobileUrl(
    String mobileUrl, {
    String? referenceDoctype,
    String? referenceName,
    String? type,
    String? fallbackPath,
  }) {
    if (mobileUrl.isEmpty) {
      if (fallbackPath != null) {
        router.push(fallbackPath);
      } else {
        navigateByNotification(
          type: referenceDoctype ?? type,
          docName: referenceName,
        );
      }
      return;
    }

    // Clean mobile_url (starts with /app/ or app/)
    String cleanUrl = mobileUrl.trim();
    if (cleanUrl.startsWith(PushNotificationValues.appPrefixWithSlashes)) {
      cleanUrl = cleanUrl.substring(5);
    } else if (cleanUrl.startsWith(PushNotificationValues.appPrefix)) {
      cleanUrl = cleanUrl.substring(4);
    }
    if (cleanUrl.startsWith('/')) {
      cleanUrl = cleanUrl.substring(1);
    }

    final parts = cleanUrl.split('/');
    final pathRoot = parts[0].toLowerCase();

    if (pathRoot == PushNotificationValues.urlNotifications) {
      router.push(notificationsPath);
      return;
    }

    // Compensatory leave must be checked before generic 'leave'
    if (pathRoot.contains(typeCompensatory)) {
      _navigateToApprovals(ApprovalType.compOff);
      return;
    }

    if (pathRoot == PushNotificationValues.urlLeaveApplication ||
        pathRoot == PushNotificationValues.urlLeave) {
      _navigateToApprovals(ApprovalType.leave);
      return;
    }

    if (pathRoot == PushNotificationValues.urlTimesheet) {
      _navigateToApprovals(ApprovalType.timesheet);
      return;
    }

    if (pathRoot == PushNotificationValues.urlAttendance ||
        pathRoot == PushNotificationValues.urlRegularization ||
        pathRoot == PushNotificationValues.urlAttendanceRegularization) {
      _navigateToApprovals(ApprovalType.attendance);
      return;
    }

    if (pathRoot == PushNotificationValues.urlPerformance ||
        pathRoot == PushNotificationValues.urlSelfAssessment) {
      router.push(performanceSelfAssessmentPath);
      return;
    }

    // Fallback: use notification metadata if available
    if (referenceDoctype != null || type != null || referenceName != null) {
      navigateByNotification(
        type: referenceDoctype ?? type,
        docName: referenceName,
      );
    } else if (fallbackPath != null) {
      router.push(fallbackPath);
    } else {
      router.push(notificationsPath);
    }
  }

  // Routes that don't require authentication
  static const List<String> _publicRoutes = [
    splashPath,
    welcomePath,
    getStartedPath,
    onboardingPath,
    loginPath,
    forgotPasswordPath,
    otpVerificationPath,
    authCallbackPath,
    commonWebViewPath,
  ];

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

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
        path: welcomePath,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: getStartedPath,
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(
        path: onboardingPath,
        builder: (context, state) => BlocProvider(
          create: (context) => OnboardingCubit(Get.find()),
          child: const OnboardingScreen(),
        ),
      ),

        GoRoute(
          path: comingSoonPath,
          builder: (context, state) {
            final title = state.extra as String? ?? 'Coming Soon';
            return ComingSoonScreen(title: title);
          },
        ),
      GoRoute(
        path: loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: dashboardPath,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<BottomNavCubit>.value(value: Get.find<BottomNavCubit>()),
            BlocProvider<DashboardCubit>.value(value: Get.find<DashboardCubit>()),
            BlocProvider<AttendanceBloc>.value(value: Get.find<AttendanceBloc>()),
            BlocProvider<LeaveBloc>.value(value: Get.find<LeaveBloc>()),
            BlocProvider<TimesheetBloc>.value(value: Get.find<TimesheetBloc>()),
            BlocProvider<ProfileBloc>.value(value: Get.find<ProfileBloc>()),
            BlocProvider<ApprovalsBloc>.value(value: Get.find<ApprovalsBloc>()),
            BlocProvider<PerformanceBloc>.value(
              value: Get.find<PerformanceBloc>()
                ..add(const PerformanceEvent.started()),
            ),
            BlocProvider<TeamEvaluationCubit>.value(
              value: Get.find<TeamEvaluationCubit>(),
            ),
            BlocProvider<TeamEvaluationFilterCubit>.value(
              value: Get.find<TeamEvaluationFilterCubit>(),
            ),
            BlocProvider<SettingsCubit>.value(value: Get.find<SettingsCubit>()),
            BlocProvider<PayslipBloc>.value(value: Get.find<PayslipBloc>()),
          ],
          child: const DashboardScreen(),
        ),
      ),
      GoRoute(
        path: authCallbackPath,
        builder: (context, state) =>
            const dhira_auth_callback.AuthCallbackScreen(),
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
        builder: (context, state) {
          final today = DateTime.now();
          return MultiBlocProvider(
            providers: [
              BlocProvider<TimesheetBloc>.value(
                value: Get.find<TimesheetBloc>()
                  ..add(TimesheetEvent.daySelected(today))
                  ..add(
                    TimesheetEvent.fetchMonthWiseRequested(
                      month: today.month,
                      year: today.year,
                    ),
                  )
                  ..add(
                    TimesheetEvent.fetchOverviewRequested(
                      month: today.month,
                      year: today.year,
                    ),
                  )
                  ..add(const TimesheetEvent.started(timesheetId: "current")),
              ),
              BlocProvider<BottomNavCubit>.value(
                value: Get.find<BottomNavCubit>(),
              ),
              BlocProvider<ApprovalsBloc>.value(
                value: Get.find<ApprovalsBloc>(),
              ),
            ],
            child: const ApplyTimesheetScreen(timesheetId: "current"),
          );
        },
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
          final today = DateTime.now();

          return MultiBlocProvider(
            providers: [
              BlocProvider<TimesheetBloc>.value(
                value: Get.find<TimesheetBloc>()
                  ..add(TimesheetEvent.daySelected(today))
                  ..add(
                    TimesheetEvent.fetchMonthWiseRequested(
                      month: today.month,
                      year: today.year,
                    ),
                  )
                  ..add(
                    TimesheetEvent.fetchOverviewRequested(
                      month: today.month,
                      year: today.year,
                    ),
                  )
                  ..add(TimesheetEvent.started(timesheetId: timesheetId)),
              ),
              BlocProvider<BottomNavCubit>.value(
                value: Get.find<BottomNavCubit>(),
              ),
              BlocProvider<ApprovalsBloc>.value(
                value: Get.find<ApprovalsBloc>(),
              ),
            ],
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
            getAttendancePunchSummaryUseCase: Get.find(),
            localStorageService: Get.find(),
            imageCompressService: Get.find(),
          ),
          child: const AttendanceRegularizationScreen(),
        ),
      ),
      GoRoute(
        path: compensatoryLeavePath,
        builder: (context, state) => BlocProvider(
          create: (context) => CompensatoryLeaveBloc(
            getCompensatoryLeaveSummaryUseCase: Get.find(),
            getCompensatoryLeaveEligibleDatesUseCase: Get.find(),
            submitCompensatoryLeaveRequestUseCase: Get.find(),
            localStorageService: Get.find(),
            getProjectsUseCase: Get.find(),
          ),
          child: const CompensatoryLeaveScreen(),
        ),
      ),

      GoRoute(
        path: performanceDashboardPath,
        builder: (context, state) => BlocProvider.value(
          value: Get.find<PerformanceBloc>(),
          child: const PerformanceDashboardScreen(),
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
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final selfAssessmentId = extra[argSelfAssessmentId] as String? ?? '';
          final evaluationId = extra[argEvaluationId] as String? ?? '';

          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: Get.find<SelfAssessmentCubit>()
                  ..initSelfAssessment(
                    selfAssessmentId: selfAssessmentId,
                    evaluationId: evaluationId,
                  ),
              ),
              BlocProvider.value(value: Get.find<FileOperationCubit>()),
            ],
            child: SelfAssessmentScreen(
              selfAssessmentId: selfAssessmentId,
              evaluationId: evaluationId,
            ),
          );
        },
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
            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: payslipPath,
        builder: (context, state) => BlocProvider.value(
          value: Get.find<PayslipBloc>(),
          child: const PayslipListScreen(),
        ),
      ),
      GoRoute(
        path: payslipDetailPath,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final name = extra[argDocName] as String? ?? '';
          return BlocProvider.value(
            value: Get.find<PayslipBloc>(),
            child: PayslipDetailScreen(name: name),
          );
        },
      ),
      GoRoute(
        path: policyPath,
        builder: (context, state) => BlocProvider.value(
          value: Get.find<PolicyBloc>()..add(const PolicyEvent.started()),
          child: const PolicyScreen(),
        ),
      ),
      GoRoute(
        path: settingsPath,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: Get.find<SettingsCubit>()),
            BlocProvider.value(value: Get.find<ProfileBloc>()),
          ],
          child: const SettingsScreen(),
        ),
      ),
    ],
  );
}
