import 'package:dhira_hrms/features/attendance/domain/usecases/get_attendance_month_summary_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_leave_history_usecase.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/dio_client.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/logging_interceptor.dart';
import '../network/network_info.dart';
import '../network/session_manager.dart';
import '../services/local_storage_service.dart';
import '../services/deep_link_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/locale_cubit.dart';
import '../../features/dashboard/presentation/bloc/dashboard_cubit.dart';
import '../../features/dashboard/presentation/bloc/bottom_nav_cubit.dart';

// Auth
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/microsoft_sso_usecase.dart';
import '../../features/auth/domain/usecases/exchange_sso_token_usecase.dart';
import '../../features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../features/auth/domain/usecases/resend_otp_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/login_cubit.dart';
import '../../features/auth/presentation/bloc/forgot_password_cubit.dart';
import '../../features/auth/presentation/bloc/otp_verification_cubit.dart';
import '../../features/auth/presentation/bloc/sso_cubit.dart';

// Organization
import '../../features/organization/data/repositories/mock_organization_repository_impl.dart';
import '../../features/organization/domain/repositories/organization_repository.dart';
import '../../features/organization/domain/usecases/get_org_chart_usecase.dart';
import '../../features/organization/domain/usecases/get_organizations_usecase.dart';
import '../../features/organization/presentation/bloc/organization_bloc.dart';

// My Task
import '../../features/my_task/data/repositories/mock_task_repository_impl.dart';
import '../../features/my_task/domain/repositories/task_repository.dart';
import '../../features/my_task/domain/usecases/get_tasks_usecase.dart';
import '../../features/my_task/presentation/bloc/task_bloc.dart';

// Attendance
import '../../features/attendance/domain/repositories/attendance_repository.dart';
import '../../features/attendance/data/datasources/attendance_remote_datasource.dart';
import '../../features/attendance/data/repositories/attendance_repository_impl.dart';
import '../../features/attendance/domain/usecases/punch_in_usecase.dart';
import '../../features/attendance/domain/usecases/punch_out_usecase.dart';
import '../../features/attendance/domain/usecases/get_attendance_logs_usecase.dart';
import '../../features/attendance/domain/usecases/get_checkin_status_usecase.dart';
import '../../features/attendance/domain/usecases/get_calendar_events_usecase.dart';
import '../../features/attendance/domain/usecases/start_break_usecase.dart';
import '../../features/attendance/domain/usecases/end_break_usecase.dart';
import '../../features/attendance/domain/usecases/get_work_durations_usecase.dart';
import '../../features/attendance/domain/usecases/get_leave_details_usecase.dart';
import '../../features/attendance/presentation/bloc/attendance_bloc.dart';

// Leave
import '../../features/leave/domain/repositories/leave_repository.dart';
import '../../features/leave/data/datasources/leave_remote_datasource.dart';
import '../../features/leave/data/repositories/leave_repository_impl.dart';
import '../../features/leave/domain/usecases/get_leaves_usecase.dart';
import '../../features/leave/domain/usecases/get_leave_types_usecase.dart';
import '../../features/leave/domain/usecases/submit_leave_usecase.dart';
import '../../features/leave/domain/usecases/get_leave_balance_usecase.dart';
import '../../features/leave/domain/usecases/delete_leave_usecase.dart';
import '../../features/leave/domain/usecases/cancel_leave_usecase.dart';
import '../../features/leave/domain/usecases/update_leave_usecase.dart';
import '../../features/leave/domain/usecases/update_leave_status_usecase.dart';

// Timesheet
import '../../features/timesheet/domain/repositories/timesheet_repository.dart';
import '../../features/timesheet/data/datasources/timesheet_remote_datasource.dart';
import '../../features/timesheet/data/repositories/timesheet_repository_impl.dart';
import '../../features/timesheet/domain/usecases/get_timesheets_usecase.dart';
import '../../features/timesheet/domain/usecases/get_single_timesheet_usecase.dart';
import '../../features/timesheet/domain/usecases/get_projects_usecase.dart';
import '../../features/timesheet/domain/usecases/create_timesheet_usecase.dart';
import '../../features/timesheet/domain/usecases/update_timesheet_usecase.dart';
import '../../features/timesheet/presentation/bloc/timesheet_bloc.dart';

// Profile
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/domain/usecases/update_avatar_usecase.dart';
import '../../features/profile/domain/usecases/change_password_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

class DependencyInjection {
  static Future<void> init() async {
    // SharedPreferences
    final sharedPrefs = await SharedPreferences.getInstance();

    // Core (Logger, Network, etc.)
    Get.lazyPut<Logger>(() => Logger(), fenix: true);
    Get.lazyPut<Connectivity>(() => Connectivity(), fenix: true);
    Get.lazyPut<NetworkInfo>(
      () => NetworkInfoImpl(Get.find<Connectivity>()),
      fenix: true,
    );
    Get.lazyPut<SessionManager>(() => SessionManager(), fenix: true);

    // Interceptors
    Get.lazyPut<AuthInterceptor>(
      () => AuthInterceptor(sharedPrefs, Get.find<SessionManager>()),
      fenix: true,
    );
    Get.lazyPut<LoggingInterceptor>(
      () => LoggingInterceptor(Get.find<Logger>()),
      fenix: true,
    );

    // Dio
    Get.lazyPut<Dio>(() => Dio(), fenix: true);

    // DioClient
    Get.lazyPut<DioClient>(
      () => DioClient(
        Get.find<Dio>(),
        Get.find<SessionManager>(),
        baseUrl: "https://dev-api.hrms.dhira.io/",
        authInterceptor: Get.find<AuthInterceptor>(),
        loggingInterceptor: Get.find<LoggingInterceptor>(),
      ),
      fenix: true,
    );

    // Local Storage
    Get.lazyPut<LocalStorageService>(
      () => LocalStorageService(sharedPrefs),
      fenix: true,
    );

    // Auth Feature
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<IAuthRepository>(
      () => AuthRepositoryImpl(
        Get.find<AuthRemoteDataSource>(),
        Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<LoginUseCase>(
      () => LoginUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<LogoutUseCase>(
      () => LogoutUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<MicrosoftSSOUseCase>(
      () => MicrosoftSSOUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<ExchangeSSOTokenUseCase>(
      () => ExchangeSSOTokenUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<ResendOtpUseCase>(
      () => ResendOtpUseCase(Get.find<IAuthRepository>()),
      fenix: true,
    );

    // Organization Feature
    Get.lazyPut<IOrganizationRepository>(
      () => MockOrganizationRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<GetOrganizationsUseCase>(
      () => GetOrganizationsUseCase(Get.find<IOrganizationRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetOrgChartUseCase>(
      () => GetOrgChartUseCase(Get.find<IOrganizationRepository>()),
      fenix: true,
    );

    // My Task Feature
    Get.lazyPut<ITaskRepository>(() => MockTaskRepositoryImpl(), fenix: true);
    Get.lazyPut<GetTasksUseCase>(
      () => GetTasksUseCase(Get.find<ITaskRepository>()),
      fenix: true,
    );

    // Attendance Feature
    Get.lazyPut<AttendanceRemoteDataSource>(
      () => AttendanceRemoteDataSourceImpl(Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<IAttendanceRepository>(
      () => AttendanceRepositoryImpl(
        Get.find<AttendanceRemoteDataSource>(),
        Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<PunchInUseCase>(
      () => PunchInUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<PunchOutUseCase>(
      () => PunchOutUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetAttendanceLogsUseCase>(
      () => GetAttendanceLogsUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetCheckinStatusUseCase>(
      () => GetCheckinStatusUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetCalendarEventsUseCase>(
      () => GetCalendarEventsUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<StartBreakUseCase>(
      () => StartBreakUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<EndBreakUseCase>(
      () => EndBreakUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetWorkDurationsUseCase>(
      () => GetWorkDurationsUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetAttendanceMonthSummaryUseCase>(
      () => GetAttendanceMonthSummaryUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetLeaveDetailsUseCase>(
      () => GetLeaveDetailsUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetLeaveHistoryUseCase>(
      () => GetLeaveHistoryUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );

    // Leave Feature
    Get.lazyPut<LeaveRemoteDataSource>(
      () => LeaveRemoteDataSourceImpl(Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<ILeaveRepository>(
      () => LeaveRepositoryImpl(
        Get.find<LeaveRemoteDataSource>(),
        Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetLeavesUseCase>(
      () => GetLeavesUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetLeaveTypesUseCase>(
      () => GetLeaveTypesUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetLeaveBalanceUseCase>(
      () => GetLeaveBalanceUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );
    Get.lazyPut<SubmitLeaveUseCase>(
      () => SubmitLeaveUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateLeaveUseCase>(
      () => UpdateLeaveUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateLeaveStatusUseCase>(
      () => UpdateLeaveStatusUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );
    Get.lazyPut<DeleteLeaveUseCase>(
      () => DeleteLeaveUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );
    Get.lazyPut<CancelLeaveUseCase>(
      () => CancelLeaveUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );

    // Timesheet Feature
    Get.lazyPut<TimesheetRemoteDataSource>(
      () => TimesheetRemoteDataSourceImpl(Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<ITimesheetRepository>(
      () => TimesheetRepositoryImpl(
        Get.find<TimesheetRemoteDataSource>(),
        Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetTimesheetsUseCase>(
      () => GetTimesheetsUseCase(Get.find<ITimesheetRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetSingleTimesheetUseCase>(
      () => GetSingleTimesheetUseCase(Get.find<ITimesheetRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetProjectsUseCase>(
      () => GetProjectsUseCase(Get.find<ITimesheetRepository>()),
      fenix: true,
    );
    Get.lazyPut<CreateTimesheetUseCase>(
      () => CreateTimesheetUseCase(Get.find<ITimesheetRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateTimesheetUseCase>(
      () => UpdateTimesheetUseCase(Get.find<ITimesheetRepository>()),
      fenix: true,
    );

    // Profile Feature
    Get.lazyPut<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<IProfileRepository>(
      () => ProfileRepositoryImpl(
        Get.find<ProfileRemoteDataSource>(),
        Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetProfileUseCase>(
      () => GetProfileUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateAvatarUseCase>(
      () => UpdateAvatarUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );

    // BLoC registrations (fenix: true allows them to be recreated if disposed)
    Get.lazyPut<AuthBloc>(
      () => AuthBloc(
        loginUseCase: Get.find<LoginUseCase>(),
        logoutUseCase: Get.find<LogoutUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<LoginCubit>(
      () => LoginCubit(loginUseCase: Get.find<LoginUseCase>()),
      fenix: true,
    );

    Get.lazyPut<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(
        forgotPasswordUseCase: Get.find<ForgotPasswordUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<OtpVerificationCubit>(
      () => OtpVerificationCubit(
        verifyOtpUseCase: Get.find<VerifyOtpUseCase>(),
        resendOtpUseCase: Get.find<ResendOtpUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<SSOCubit>(
      () => SSOCubit(
        microsoftSSOUseCase: Get.find<MicrosoftSSOUseCase>(),
        exchangeSSOTokenUseCase: Get.find<ExchangeSSOTokenUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<DeepLinkService>(
      () => DeepLinkService(Get.find<SSOCubit>()),
      fenix: true,
    );

    Get.lazyPut<AttendanceBloc>(
      () => AttendanceBloc(
        punchInUseCase: Get.find<PunchInUseCase>(),
        punchOutUseCase: Get.find<PunchOutUseCase>(),
        getCheckinStatusUseCase: Get.find<GetCheckinStatusUseCase>(),
        getAttendanceLogsUseCase: Get.find<GetAttendanceLogsUseCase>(),
        getCalendarEventsUseCase: Get.find<GetCalendarEventsUseCase>(),
        startBreakUseCase: Get.find<StartBreakUseCase>(),
        endBreakUseCase: Get.find<EndBreakUseCase>(),
        getWorkDurationsUseCase: Get.find<GetWorkDurationsUseCase>(),
        getAttendanceMonthSummaryUseCase:
            Get.find<GetAttendanceMonthSummaryUseCase>(),
        getLeaveDetailsUseCase: Get.find<GetLeaveDetailsUseCase>(),
        getLeaveHistoryUseCase: Get.find<GetLeaveHistoryUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<LeaveBloc>(
      () => LeaveBloc(
        getLeavesUseCase: Get.find<GetLeavesUseCase>(),
        getLeaveTypesUseCase: Get.find<GetLeaveTypesUseCase>(),
        getLeaveBalanceUseCase: Get.find<GetLeaveBalanceUseCase>(),
        submitLeaveUseCase: Get.find<SubmitLeaveUseCase>(),
        updateLeaveUseCase: Get.find<UpdateLeaveUseCase>(),
        updateLeaveStatusUseCase: Get.find<UpdateLeaveStatusUseCase>(),
        deleteLeaveUseCase: Get.find<DeleteLeaveUseCase>(),
        cancelLeaveUseCase: Get.find<CancelLeaveUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<TimesheetBloc>(
      () => TimesheetBloc(
        getTimesheetsUseCase: Get.find<GetTimesheetsUseCase>(),
        getSingleTimesheetUseCase: Get.find<GetSingleTimesheetUseCase>(),
        getProjectsUseCase: Get.find<GetProjectsUseCase>(),
        createTimesheetUseCase: Get.find<CreateTimesheetUseCase>(),
        updateTimesheetUseCase: Get.find<UpdateTimesheetUseCase>(),
        authRepository: Get.find<IAuthRepository>(),
        sharedPreferences: sharedPrefs,
      ),
      fenix: true,
    );

    Get.lazyPut<ProfileBloc>(
      () => ProfileBloc(
        getProfileUseCase: Get.find<GetProfileUseCase>(),
        updateAvatarUseCase: Get.find<UpdateAvatarUseCase>(),
        changePasswordUseCase: Get.find<ChangePasswordUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<OrganizationBloc>(
      () => OrganizationBloc(
        getOrganizationsUseCase: Get.find<GetOrganizationsUseCase>(),
        getOrgChartUseCase: Get.find<GetOrgChartUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<TaskBloc>(
      () => TaskBloc(getTasksUseCase: Get.find<GetTasksUseCase>()),
      fenix: true,
    );

    Get.lazyPut<DashboardCubit>(() => DashboardCubit(), fenix: true);
    Get.lazyPut<BottomNavCubit>(() => BottomNavCubit(), fenix: true);
    Get.lazyPut<LocaleCubit>(() => LocaleCubit(), fenix: true);
  }
}
