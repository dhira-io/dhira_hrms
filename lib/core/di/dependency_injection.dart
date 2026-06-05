import 'package:dhira_hrms/features/approvals/domain/usecases/get_pending_requests_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/submit_leave_workflow_action_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_attendance_month_summary_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/submit_regularization_use_case.dart';
import 'package:dhira_hrms/features/performance/data/datasources/performance_remote_datasource.dart';
import 'package:dhira_hrms/features/performance/data/repositories/performance_repository_impl.dart';
import 'package:dhira_hrms/features/performance/domain/repositories/i_performance_repository.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/get_active_pms_cycle_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/update_goal_usecase.dart';

import '../../features/payslip/data/datasources/payslip_remote_datasource.dart';
import '../../features/payslip/data/repositories/payslip_repository_impl.dart';
import '../../features/payslip/domain/repositories/i_payslip_repository.dart';
import '../../features/payslip/domain/usecases/get_payslips_usecase.dart';
import '../../features/payslip/domain/usecases/get_payslip_detail_usecase.dart';
import '../../features/payslip/presentation/bloc/payslip_bloc.dart';

import '../../features/leave/domain/usecases/get_overlap_leaves_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_leave_history_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_team_leaves_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_holiday_list_leave_policy_usecase.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../features/timesheet/domain/usecases/timesheet_upload_file_usecase.dart'
    as timesheet_upload;
import '../network/dio_client.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/logging_interceptor.dart';
import '../network/network_info.dart';
import '../network/session_manager.dart';
import '../constants/api_constants.dart';
import '../services/local_storage_service.dart';
import '../services/image_compress_service.dart';
import '../services/deep_link_service.dart';
import '../services/notification_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/locale_cubit.dart';
import '../bloc/theme_cubit.dart';
import '../../features/dashboard/presentation/bloc/dashboard_cubit.dart';
import '../../features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/i_dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/get_dashboard_stats_usecase.dart';

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
import '../../features/attendance/domain/repositories/i_attendance_repository.dart';
import '../../features/attendance/data/datasources/attendance_remote_datasource.dart';
import '../../features/attendance/data/repositories/attendance_repository_impl.dart';
import '../../features/attendance/domain/usecases/punch_in_usecase.dart';
import '../../features/attendance/domain/usecases/punch_out_usecase.dart';
import '../../features/attendance/domain/usecases/get_checkin_status_usecase.dart';
import '../../features/attendance/domain/usecases/get_calendar_events_usecase.dart';
import '../../features/attendance/domain/usecases/start_break_usecase.dart';
import '../../features/attendance/domain/usecases/end_break_usecase.dart';
import '../../features/attendance/domain/usecases/get_leave_details_usecase.dart'
    as attendance_leave;
import '../../features/attendance/presentation/bloc/attendance_bloc.dart';
import '../../features/attendance/domain/usecases/upload_file_use_case.dart';

// Leave
import '../../features/leave/domain/repositories/leave_repository.dart';
import '../../features/leave/data/datasources/leave_remote_datasource.dart';
import '../../features/leave/data/repositories/leave_repository_impl.dart';
import '../../features/leave/domain/usecases/get_leave_types_usecase.dart';
import '../../features/leave/domain/usecases/submit_leave_usecase.dart';
import '../../features/leave/domain/usecases/get_leave_balance_usecase.dart';
import '../../features/leave/domain/usecases/update_leave_usecase.dart';
import '../../features/leave/domain/usecases/get_leave_statistics_usecase.dart';
import '../../features/leave/domain/usecases/upload_file_usecase.dart';

// Timesheet
import '../../features/timesheet/domain/repositories/timesheet_repository.dart';
import '../../features/timesheet/data/datasources/timesheet_remote_datasource.dart';
import '../../features/timesheet/data/repositories/timesheet_repository_impl.dart';
import '../../features/timesheet/domain/usecases/get_projects_usecase.dart';
import '../../features/timesheet/domain/usecases/create_timesheet_usecase.dart';
import '../../features/timesheet/domain/usecases/update_timesheet_usecase.dart';
import '../../features/approvals/timesheetapproval/domain/usecases/get_timesheet_details_usecase.dart';
import '../../features/approvals/timesheetapproval/domain/usecases/sync_timesheet_week_wise_usecase.dart';
import '../../features/approvals/timesheetapproval/domain/usecases/get_employees_usecase.dart';
import '../../features/approvals/timesheetapproval/domain/usecases/delete_approval_timesheet_usecase.dart';
import '../../features/timesheet/domain/usecases/get_week_wise_timesheet_usecase.dart';
import '../../features/timesheet/domain/usecases/delete_timesheet_entry_usecase.dart';
import '../../features/timesheet/domain/usecases/delete_timesheet_usecase.dart';
import '../../features/timesheet/domain/usecases/get_timesheet_overview_usecase.dart';
import '../../features/timesheet/presentation/bloc/timesheet_bloc.dart';

// Profile
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/domain/usecases/update_avatar_usecase.dart';
import '../../features/profile/domain/usecases/change_password_usecase.dart';
import '../../features/profile/domain/usecases/update_profile_details_usecase.dart';
import '../../features/profile/domain/usecases/delete_profile_image_usecase.dart';
import '../../features/profile/domain/usecases/get_employee_resume_usecase.dart';
import '../../features/profile/domain/usecases/search_skills_usecase.dart';
import '../../features/profile/domain/usecases/search_designations_usecase.dart';
import '../../features/profile/domain/usecases/get_sub_skills_usecase.dart';
import '../../features/profile/domain/usecases/upsert_resume_row_usecase.dart';
import '../../features/profile/domain/usecases/delete_resume_row_usecase.dart';
import '../../features/profile/domain/usecases/update_employee_resume_usecase.dart';
import '../../features/profile/domain/usecases/update_employee_sub_skills_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
// Performance
import '../../features/performance/domain/usecases/get_job_family_usecase.dart';
import '../../features/performance/domain/usecases/get_pms_goals_usecase.dart';
import '../../features/performance/domain/usecases/get_goal_details_usecase.dart';
import '../../features/performance/domain/usecases/get_kra_list_usecase.dart';
import '../../features/performance/domain/usecases/check_manager_status_usecase.dart';
import '../../features/performance/presentation/bloc/performance_bloc.dart';
import '../../features/performance/presentation/bloc/kra_add_cubit.dart';
import '../../features/performance/domain/usecases/get_team_evaluations_usecase.dart';
import '../../features/performance/domain/usecases/get_employee_info_usecase.dart';
import '../../features/performance/domain/usecases/get_active_self_assessment_id_usecase.dart';
import '../../features/performance/domain/usecases/get_self_assessment_details_usecase.dart';
import '../../features/performance/domain/usecases/update_evaluation_usecase.dart';
import '../../features/performance/domain/usecases/update_self_assessment_usecase.dart';
import '../../features/performance/domain/usecases/get_sa_tracking_usecase.dart';
import '../../features/performance/domain/usecases/update_sa_tracking_usecase.dart';
import '../../features/performance/domain/usecases/upload_sa_attachment_usecase.dart';
import '../../features/performance/domain/usecases/delete_sa_attachment_usecase.dart';
import '../../features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import '../../features/performance/presentation/cubit/team_evaluation/team_evaluation_cubit.dart';
import '../../features/performance/presentation/cubit/team_evaluation/team_evaluation_filter_cubit.dart';
import '../../features/settings/presentation/bloc/settings_cubit.dart';
import '../../features/settings/presentation/bloc/notification_settings_cubit.dart';
import '../../features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';

// Approvals
import '../../features/approvals/data/datasources/approvals_remote_datasource.dart';
import '../../features/approvals/data/repositories/approvals_repository_impl.dart';
import '../../features/approvals/domain/repositories/i_approvals_repository.dart';
import '../../features/approvals/domain/usecases/get_approvals_access_usecase.dart';
import '../../features/approvals/domain/usecases/get_approvals_summary_usecase.dart';
import '../../features/approvals/domain/usecases/add_comment_usecase.dart';
import '../../features/approvals/domain/usecases/submit_attendance_workflow_action_usecase.dart';
import '../../features/approvals/domain/usecases/submit_timesheet_workflow_action_usecase.dart';
import '../../features/approvals/domain/usecases/submit_comp_off_workflow_action_usecase.dart';
import '../../features/approvals/domain/usecases/get_comments_usecase.dart';
import '../../features/approvals/leaveapproval/data/datasources/leave_approval_remote_datasource.dart';
import '../../features/approvals/leaveapproval/data/repositories/leave_approval_repository_impl.dart';
import '../../features/approvals/leaveapproval/domain/repositories/i_leave_approval_repository.dart';
import '../../features/approvals/leaveapproval/domain/usecases/get_pending_leaves_usecase.dart';
import '../../features/approvals/leaveapproval/domain/usecases/update_leave_approval_usecase.dart';
import '../../features/approvals/leaveapproval/domain/usecases/get_leave_types_approval_usecase.dart';
import '../../features/approvals/leaveapproval/domain/usecases/get_leave_balance_approval_usecase.dart';
import '../../features/approvals/leaveapproval/domain/usecases/get_leave_statistics_approval_usecase.dart';
import '../../features/approvals/leaveapproval/domain/usecases/get_overlap_leaves_approval_usecase.dart';
import '../../features/approvals/leaveapproval/domain/usecases/upload_leave_file_usecase.dart';
import '../../features/approvals/leaveapproval/domain/usecases/add_leave_comment_usecase.dart';
import '../../features/approvals/leaveapproval/domain/usecases/get_leave_comments_usecase.dart';
import '../../features/approvals/timesheetapproval/data/datasources/timesheet_approval_remote_datasource.dart';
import '../../features/approvals/timesheetapproval/data/repositories/timesheet_approval_repository_impl.dart';
import '../../features/approvals/timesheetapproval/domain/repositories/i_timesheet_approval_repository.dart';
import '../../features/approvals/timesheetapproval/domain/usecases/get_pending_timesheets_usecase.dart';
import '../../features/approvals/timesheetapproval/domain/usecases/submit_timesheet_action_usecase.dart';
import '../../features/approvals/presentation/bloc/approvals_bloc.dart';

import '../../features/notifications/data/datasources/notification_remote_data_source.dart';
import '../../features/notifications/data/repositories/notification_repository_impl.dart';
import '../../features/notifications/domain/repositories/notification_repository.dart';
import '../../features/notifications/domain/usecases/get_notifications_usecase.dart';
import '../../features/notifications/domain/usecases/mark_all_read_usecase.dart';
import '../../features/notifications/domain/usecases/mark_read_usecase.dart';
import '../../features/notifications/domain/usecases/store_fcm_token_usecase.dart';
import '../../features/notifications/domain/usecases/deactivate_device_usecase.dart';
import '../../core/services/device_id_service.dart';
import '../../features/notifications/presentation/bloc/notification_bloc.dart';

class DependencyInjection {
  static Future<void> init() async {
    // SharedPreferences
    final sharedPrefs = await SharedPreferences.getInstance();

    // Core (Logger, Network, etc.)
    Get.lazyPut<Logger>(() => Logger(), fenix: true);
    Get.lazyPut<ImageCompressService>(
      () => ImageCompressService(),
      fenix: true,
    );
    Get.lazyPut<Connectivity>(() => Connectivity(), fenix: true);
    Get.lazyPut<NetworkInfo>(
      () => NetworkInfoImpl(Get.find<Connectivity>()),
      fenix: true,
    );
    Get.lazyPut<SessionManager>(() => SessionManager(), fenix: true);
    Get.lazyPut<DeviceIdService>(() => DeviceIdService(), fenix: true);

    // Interceptors
    Get.lazyPut<AuthInterceptor>(
      () => AuthInterceptor(sharedPrefs, Get.find<SessionManager>()),
      fenix: true,
    );
    Get.lazyPut<LoggingInterceptor>(() => LoggingInterceptor(), fenix: true);

    // Dio
    Get.lazyPut<Dio>(() => Dio(), fenix: true);

    // DioClient
    Get.lazyPut<DioClient>(
      () => DioClient(
        Get.find<Dio>(),
        Get.find<SessionManager>(),
        baseUrl: ApiConstants.baseUrl,
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

    // Notification Service
    Get.lazyPut<NotificationManager>(() => NotificationManager(), fenix: true);

    // Auth Feature
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<IAuthRepository>(
      () => AuthRepositoryImpl(
        Get.find<AuthRemoteDataSource>(),
        Get.find<NetworkInfo>(),
        Get.find<LocalStorageService>(),
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
    Get.lazyPut<IAttendanceRemoteDataSource>(
      () => AttendanceRemoteDataSourceImpl(dioClient: Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<IAttendanceRepository>(
      () => AttendanceRepositoryImpl(
        remoteDataSource: Get.find<IAttendanceRemoteDataSource>(),
        networkInfo: Get.find<NetworkInfo>(),
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
    Get.lazyPut<GetAttendanceMonthSummaryUseCase>(
      () => GetAttendanceMonthSummaryUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<attendance_leave.GetLeaveDetailsUseCase>(
      () => attendance_leave.GetLeaveDetailsUseCase(
        Get.find<IAttendanceRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetLeaveHistoryUseCase>(
      () => GetLeaveHistoryUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetTeamLeavesUseCase>(
      () => GetTeamLeavesUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetHolidayListLeavePolicyUseCase>(
      () => GetHolidayListLeavePolicyUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<SubmitRegularizationUseCase>(
      () => SubmitRegularizationUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<AttendanceRegularizationUploadFileUseCase>(
      () => AttendanceRegularizationUploadFileUseCase(
        Get.find<IAttendanceRepository>(),
      ),
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
    Get.lazyPut<GetLeaveStatisticsUseCase>(
      () => GetLeaveStatisticsUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetOverlapLeavesUseCase>(
      () => GetOverlapLeavesUseCase(Get.find<ILeaveRepository>()),
      fenix: true,
    );
    Get.lazyPut<UploadFileUseCase>(
      () => UploadFileUseCase(Get.find<ILeaveRepository>()),
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
    Get.lazyPut<GetWeekWiseTimesheetUseCase>(
      () => GetWeekWiseTimesheetUseCase(Get.find<ITimesheetRepository>()),
      fenix: true,
    );
    Get.lazyPut<DeleteTimesheetEntryUseCase>(
      () => DeleteTimesheetEntryUseCase(Get.find<ITimesheetRepository>()),
      fenix: true,
    );

    Get.lazyPut<DeleteTimesheetUseCase>(
      () => DeleteTimesheetUseCase(Get.find<ITimesheetRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetTimesheetOverviewUseCase>(
      () => GetTimesheetOverviewUseCase(Get.find<ITimesheetRepository>()),
      fenix: true,
    );

    Get.lazyPut<timesheet_upload.TimesheetUploadFileUseCase>(
      () => timesheet_upload.TimesheetUploadFileUseCase(
        Get.find<ITimesheetRepository>(),
      ),
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
    Get.lazyPut<UpdateProfileDetailsUseCase>(
      () => UpdateProfileDetailsUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<DeleteProfileImageUseCase>(
      () => DeleteProfileImageUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetEmployeeResumeUseCase>(
      () => GetEmployeeResumeUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<SearchSkillsUseCase>(
      () => SearchSkillsUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<SearchDesignationsUseCase>(
      () => SearchDesignationsUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetSubSkillsUseCase>(
      () => GetSubSkillsUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpsertResumeRowUseCase>(
      () => UpsertResumeRowUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<DeleteResumeRowUseCase>(
      () => DeleteResumeRowUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateEmployeeResumeUseCase>(
      () => UpdateEmployeeResumeUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateEmployeeSubSkillsUseCase>(
      () => UpdateEmployeeSubSkillsUseCase(Get.find<IProfileRepository>()),
      fenix: true,
    );

    // Dashboard Feature
    Get.lazyPut<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<IDashboardRepository>(
      () => DashboardRepositoryImpl(
        remoteDataSource: Get.find<DashboardRemoteDataSource>(),
        networkInfo: Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetDashboardStatsUseCase>(
      () => GetDashboardStatsUseCase(Get.find<IDashboardRepository>()),
      fenix: true,
    );

    // Approvals Feature
    Get.lazyPut<ApprovalsRemoteDataSource>(
      () => ApprovalsRemoteDataSourceImpl(
        Get.find<DioClient>(),
        Get.find<LocalStorageService>(),
        Get.find<LeaveApprovalRemoteDataSource>(),
        Get.find<TimesheetApprovalRemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<IApprovalsRepository>(
      () => ApprovalsRepositoryImpl(
        Get.find<ApprovalsRemoteDataSource>(),
        Get.find<NetworkInfo>(),
        Get.find<ILeaveApprovalRepository>(),
        Get.find<ITimesheetApprovalRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetApprovalsAccessUseCase>(
      () => GetApprovalsAccessUseCase(Get.find<IApprovalsRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetApprovalsSummaryUseCase>(
      () => GetApprovalsSummaryUseCase(Get.find<IApprovalsRepository>()),
      fenix: true,
    );
    Get.lazyPut<AddCommentUseCase>(
      () => AddCommentUseCase(Get.find<IApprovalsRepository>()),
      fenix: true,
    );
    Get.lazyPut<SubmitLeaveWorkflowActionUseCase>(
      () => SubmitLeaveWorkflowActionUseCase(
        Get.find<ILeaveApprovalRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<SubmitAttendanceWorkflowActionUseCase>(
      () => SubmitAttendanceWorkflowActionUseCase(
        Get.find<IApprovalsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<SubmitTimesheetWorkflowActionUseCase>(
      () => SubmitTimesheetWorkflowActionUseCase(
        Get.find<IApprovalsRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<SubmitCompOffWorkflowActionUseCase>(
      () =>
          SubmitCompOffWorkflowActionUseCase(Get.find<IApprovalsRepository>()),
      fenix: true,
    );
    // NEW: Register the missing Pending Requests UseCase
    Get.lazyPut<GetPendingRequestsUseCase>(
      () => GetPendingRequestsUseCase(Get.find<IApprovalsRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetCommentsUseCase>(
      () => GetCommentsUseCase(Get.find<IApprovalsRepository>()),
      fenix: true,
    );

    // Leave Approval Sub-feature
    Get.lazyPut<LeaveApprovalRemoteDataSource>(
      () => LeaveApprovalRemoteDataSourceImpl(
        Get.find<DioClient>(),
        Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<ILeaveApprovalRepository>(
      () => LeaveApprovalRepositoryImpl(
        Get.find<LeaveApprovalRemoteDataSource>(),
        Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetPendingLeavesUseCase>(
      () => GetPendingLeavesUseCase(Get.find<ILeaveApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateLeaveApprovalUseCase>(
      () => UpdateLeaveApprovalUseCase(Get.find<ILeaveApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetLeaveTypesApprovalUseCase>(
      () => GetLeaveTypesApprovalUseCase(Get.find<ILeaveApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetLeaveBalanceApprovalUseCase>(
      () =>
          GetLeaveBalanceApprovalUseCase(Get.find<ILeaveApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetLeaveStatisticsApprovalUseCase>(
      () => GetLeaveStatisticsApprovalUseCase(
        Get.find<ILeaveApprovalRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetOverlapLeavesApprovalUseCase>(
      () =>
          GetOverlapLeavesApprovalUseCase(Get.find<ILeaveApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<UploadLeaveFileUseCase>(
      () => UploadLeaveFileUseCase(Get.find<ILeaveApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<AddLeaveCommentUseCase>(
      () => AddLeaveCommentUseCase(Get.find<ILeaveApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetLeaveCommentsUseCase>(
      () => GetLeaveCommentsUseCase(Get.find<ILeaveApprovalRepository>()),
      fenix: true,
    );

    // Timesheet Approval Sub-feature
    Get.lazyPut<TimesheetApprovalRemoteDataSource>(
      () => TimesheetApprovalRemoteDataSourceImpl(Get.find<DioClient>()),
      fenix: true,
    );

    // Performance Feature
    Get.lazyPut<IPerformanceRemoteDataSource>(
      () => PerformanceRemoteDataSourceImpl(dioClient: Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<IPerformanceRepository>(
      () => PerformanceRepositoryImpl(
        remoteDataSource: Get.find<IPerformanceRemoteDataSource>(),
        networkInfo: Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetJobFamilyUseCase>(
      () => GetJobFamilyUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetActivePmsCycleUseCase>(
      () => GetActivePmsCycleUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetPmsGoalsUseCase>(
      () => GetPmsGoalsUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetGoalDetailsUseCase>(
      () => GetGoalDetailsUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateGoalUseCase>(
      () => UpdateGoalUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetKraListUseCase>(
      () => GetKraListUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetTeamEvaluationsUseCase>(
      () => GetTeamEvaluationsUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetEmployeeInfoUseCase>(
      () => GetEmployeeInfoUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetActiveSelfAssessmentIdUseCase>(
      () =>
          GetActiveSelfAssessmentIdUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetSelfAssessmentDetailsUseCase>(
      () => GetSelfAssessmentDetailsUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateEvaluationUseCase>(
      () => UpdateEvaluationUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateSelfAssessmentUseCase>(
      () => UpdateSelfAssessmentUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetSaTrackingUseCase>(
      () => GetSaTrackingUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<UpdateSaTrackingUseCase>(
      () => UpdateSaTrackingUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<UploadSaAttachmentUseCase>(
      () => UploadSaAttachmentUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<DeleteSaAttachmentUseCase>(
      () => DeleteSaAttachmentUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );
    Get.lazyPut<CheckManagerStatusUseCase>(
      () => CheckManagerStatusUseCase(Get.find<IPerformanceRepository>()),
      fenix: true,
    );

    // Notifications Feature
    Get.lazyPut<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(dioClient: Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<INotificationRepository>(
      () => NotificationRepositoryImpl(
        remoteDataSource: Get.find<NotificationRemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(
        repository: Get.find<INotificationRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<MarkAllReadUseCase>(
      () => MarkAllReadUseCase(Get.find<INotificationRepository>()),
      fenix: true,
    );
    Get.lazyPut<MarkReadUseCase>(
      () => MarkReadUseCase(Get.find<INotificationRepository>()),
      fenix: true,
    );
    Get.lazyPut<StoreFcmTokenUseCase>(
      () =>
          StoreFcmTokenUseCase(repository: Get.find<INotificationRepository>()),
      fenix: true,
    );
    Get.lazyPut<DeactivateDeviceUseCase>(
      () => DeactivateDeviceUseCase(
        repository: Get.find<INotificationRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ITimesheetApprovalRepository>(
      () => TimesheetApprovalRepositoryImpl(
        Get.find<TimesheetApprovalRemoteDataSource>(),
        Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetPendingTimesheetsUseCase>(
      () =>
          GetPendingTimesheetsUseCase(Get.find<ITimesheetApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<SubmitTimesheetActionUseCase>(
      () => SubmitTimesheetActionUseCase(
        Get.find<ITimesheetApprovalRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetTimesheetDetailsUseCase>(
      () =>
          GetTimesheetDetailsUseCase(Get.find<ITimesheetApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<SyncTimesheetWeekWiseUseCase>(
      () => SyncTimesheetWeekWiseUseCase(
        Get.find<ITimesheetApprovalRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetEmployeesUseCase>(
      () => GetEmployeesUseCase(Get.find<ITimesheetApprovalRepository>()),
      fenix: true,
    );
    Get.lazyPut<DeleteApprovalTimesheetUseCase>(
      () => DeleteApprovalTimesheetUseCase(
        Get.find<ITimesheetApprovalRepository>(),
      ),
      fenix: true,
    );

    // BLoCs/Cubits
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
      () => DeepLinkService(),
      fenix: true,
    );

    // Attendance BLoC remains global as it's used in multiple tabs
    Get.lazyPut<AttendanceBloc>(
      () => AttendanceBloc(
        punchInUseCase: Get.find<PunchInUseCase>(),
        punchOutUseCase: Get.find<PunchOutUseCase>(),
        getCheckinStatusUseCase: Get.find<GetCheckinStatusUseCase>(),
        getCalendarEventsUseCase: Get.find<GetCalendarEventsUseCase>(),
        startBreakUseCase: Get.find<StartBreakUseCase>(),
        endBreakUseCase: Get.find<EndBreakUseCase>(),
        getAttendanceMonthSummaryUseCase:
            Get.find<GetAttendanceMonthSummaryUseCase>(),
        getLeaveDetailsUseCase:
            Get.find<attendance_leave.GetLeaveDetailsUseCase>(),
        getLeaveHistoryUseCase: Get.find<GetLeaveHistoryUseCase>(),
        getTeamLeavesUseCase: Get.find<GetTeamLeavesUseCase>(),
        getHolidayListLeavePolicyUseCase:
            Get.find<GetHolidayListLeavePolicyUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<LeaveBloc>(
      () => LeaveBloc(
        getLeaveTypesUseCase: Get.find<GetLeaveTypesUseCase>(),
        getLeaveBalanceUseCase: Get.find<GetLeaveBalanceUseCase>(),
        getLeaveStatisticsUseCase: Get.find<GetLeaveStatisticsUseCase>(),
        submitLeaveUseCase: Get.find<SubmitLeaveUseCase>(),
        updateLeaveUseCase: Get.find<UpdateLeaveUseCase>(),
        getOverlapLeavesUseCase: Get.find<GetOverlapLeavesUseCase>(),
        uploadFileUseCase: Get.find<UploadFileUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<TimesheetBloc>(
      () => TimesheetBloc(
        getProjectsUseCase: Get.find<GetProjectsUseCase>(),
        createTimesheetUseCase: Get.find<CreateTimesheetUseCase>(),
        updateTimesheetUseCase: Get.find<UpdateTimesheetUseCase>(),
        getWeekWiseTimesheetUseCase: Get.find<GetWeekWiseTimesheetUseCase>(),
        deleteTimesheetEntryUseCase: Get.find<DeleteTimesheetEntryUseCase>(),
        deleteTimesheetUseCase: Get.find<DeleteTimesheetUseCase>(),
        getTimesheetOverviewUseCase: Get.find<GetTimesheetOverviewUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),
        uploadFileUseCase:
            Get.find<timesheet_upload.TimesheetUploadFileUseCase>(),
        imageCompressService: Get.find<ImageCompressService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ProfileBloc>(
      () => ProfileBloc(
        getProfileUseCase: Get.find<GetProfileUseCase>(),
        updateAvatarUseCase: Get.find<UpdateAvatarUseCase>(),
        changePasswordUseCase: Get.find<ChangePasswordUseCase>(),
        updateProfileDetailsUseCase: Get.find<UpdateProfileDetailsUseCase>(),
        deleteProfileImageUseCase: Get.find<DeleteProfileImageUseCase>(),
        getEmployeeResumeUseCase: Get.find<GetEmployeeResumeUseCase>(),
        upsertResumeRowUseCase: Get.find<UpsertResumeRowUseCase>(),
        deleteResumeRowUseCase: Get.find<DeleteResumeRowUseCase>(),
        updateEmployeeResumeUseCase: Get.find<UpdateEmployeeResumeUseCase>(),
        updateEmployeeSubSkillsUseCase: Get.find<UpdateEmployeeSubSkillsUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),
        imageCompressService: Get.find<ImageCompressService>(),
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
    Get.lazyPut<PerformanceBloc>(
      () => PerformanceBloc(
        getJobFamilyUseCase: Get.find<GetJobFamilyUseCase>(),
        getActivePmsCycleUseCase: Get.find<GetActivePmsCycleUseCase>(),
        getPmsGoalsUseCase: Get.find<GetPmsGoalsUseCase>(),
        getGoalDetailsUseCase: Get.find<GetGoalDetailsUseCase>(),
        updateGoalUseCase: Get.find<UpdateGoalUseCase>(),
        checkManagerStatusUseCase: Get.find<CheckManagerStatusUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );
    Get.create<KraAddCubit>(
      () => KraAddCubit(getKraListUseCase: Get.find<GetKraListUseCase>()),
    );
    Get.lazyPut<TeamEvaluationCubit>(
      () => TeamEvaluationCubit(
        Get.find<GetTeamEvaluationsUseCase>(),
        Get.find<GetEmployeeInfoUseCase>(),
      ),
      fenix: true,
    );
    Get.lazyPut<TeamEvaluationFilterCubit>(
      () => TeamEvaluationFilterCubit(),
      fenix: true,
    );
    Get.lazyPut<SelfAssessmentCubit>(
      () => SelfAssessmentCubit(
        Get.find<GetActiveSelfAssessmentIdUseCase>(),
        Get.find<GetSelfAssessmentDetailsUseCase>(),
        Get.find<UpdateEvaluationUseCase>(),
        Get.find<UpdateSelfAssessmentUseCase>(),
        Get.find<GetSaTrackingUseCase>(),
        Get.find<UpdateSaTrackingUseCase>(),
        Get.find<UploadSaAttachmentUseCase>(),
        Get.find<DeleteSaAttachmentUseCase>(),
        Get.find<ImageCompressService>(),
        Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<NotificationBloc>(
      () => NotificationBloc(
        getNotificationsUseCase: Get.find<GetNotificationsUseCase>(),
        markAllReadUseCase: Get.find<MarkAllReadUseCase>(),
        markReadUseCase: Get.find<MarkReadUseCase>(),
      ),
      fenix: true,
    );

    // UPDATED: Injected the new getPendingRequestsUseCase into ApprovalsBloc
    Get.lazyPut<ApprovalsBloc>(
      () => ApprovalsBloc(
        getApprovalsAccessUseCase: Get.find<GetApprovalsAccessUseCase>(),
        getApprovalsSummaryUseCase: Get.find<GetApprovalsSummaryUseCase>(),
        getPendingRequestsUseCase: Get.find<GetPendingRequestsUseCase>(),
        submitLeaveWorkflowActionUseCase:
            Get.find<SubmitLeaveWorkflowActionUseCase>(),
        submitAttendanceWorkflowActionUseCase:
            Get.find<SubmitAttendanceWorkflowActionUseCase>(),
        submitTimesheetWorkflowActionUseCase:
            Get.find<SubmitTimesheetWorkflowActionUseCase>(),
        submitCompOffWorkflowActionUseCase:
            Get.find<SubmitCompOffWorkflowActionUseCase>(),
        addCommentUseCase: Get.find<AddCommentUseCase>(),
        getCommentsUseCase: Get.find<GetCommentsUseCase>(),
        getTimesheetDetailsUseCase: Get.find<GetTimesheetDetailsUseCase>(),
        syncTimesheetWeekWiseUseCase: Get.find<SyncTimesheetWeekWiseUseCase>(),
        getProjectsUseCase: Get.find<GetProjectsUseCase>(),
        getEmployeesUseCase: Get.find<GetEmployeesUseCase>(),
        deleteTimesheetUseCase: Get.find<DeleteApprovalTimesheetUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<DashboardCubit>(
      () => DashboardCubit(
        getDashboardStatsUseCase: Get.find<GetDashboardStatsUseCase>(),
      ),
      fenix: true,
    );
    Get.lazyPut<BottomNavCubit>(() => BottomNavCubit(), fenix: true);
    Get.lazyPut<LocaleCubit>(() => LocaleCubit(), fenix: true);
    Get.lazyPut<ThemeCubit>(
      () => ThemeCubit(Get.find<LocalStorageService>()),
      fenix: true,
    );
    Get.lazyPut<SettingsCubit>(
      () => SettingsCubit(
        getProfileUseCase: Get.find<GetProfileUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<NotificationSettingsCubit>(
      () => NotificationSettingsCubit(),
      fenix: true,
    );
    Get.lazyPut<FileOperationCubit>(
      () => FileOperationCubit(
        dioClient: Get.find<DioClient>(),
        localStorageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );

    // Payslip
    Get.lazyPut<PayslipRemoteDataSource>(
      () => PayslipRemoteDataSourceImpl(Get.find<DioClient>()),
      fenix: true,
    );
    Get.lazyPut<IPayslipRepository>(
      () => PayslipRepositoryImpl(
        remoteDataSource: Get.find<PayslipRemoteDataSource>(),
        networkInfo: Get.find<NetworkInfo>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetPayslipsUseCase>(
      () => GetPayslipsUseCase(Get.find<IPayslipRepository>()),
      fenix: true,
    );
    Get.lazyPut<GetPayslipDetailUseCase>(
      () => GetPayslipDetailUseCase(Get.find<IPayslipRepository>()),
      fenix: true,
    );
    Get.lazyPut<PayslipBloc>(
      () => PayslipBloc(
        getPayslipsUseCase: Get.find<GetPayslipsUseCase>(),
        getPayslipDetailUseCase: Get.find<GetPayslipDetailUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );
  }
}
