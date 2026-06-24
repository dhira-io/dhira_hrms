import 'dart:async';
import 'package:dhira_hrms/features/attendance/presentation/widgets/punch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_event.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_state.dart';
import 'package:dhira_hrms/features/attendance/presentation/dialogs/punch_out_dialog.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:get/get.dart';

class HomeUserClockCard extends StatefulWidget {
  const HomeUserClockCard({super.key});

  @override
  State<HomeUserClockCard> createState() => _HomeUserClockCardState();
}

class _HomeUserClockCardState extends State<HomeUserClockCard> with WidgetsBindingObserver {
  Timer? _pollingTimer;
  Timer? _timer;
  int _workedSeconds = 0;
  int? _serverTimeMs;
  bool _isPunchedIn = false;
  bool _isOnBreak = false;
  String? _firstIn;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted) setState(() {});
        });
        _startPolling();
        _fetchInitialData();
      }
    });
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        context.read<AttendanceBloc>().add(const AttendanceEvent.checkStatusRequested());
      }
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) _stopPolling();
    else if (state == AppLifecycleState.resumed) _startPolling();
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;
    final bloc = context.read<AttendanceBloc>();
    final l10n = AppLocalizations.of(context)!;

    bloc.state.maybeWhen(
      loaded: (status, logs, calendarEvents, _, __, _, _, _, _, _) {
        _handleStatusLoaded(status, l10n);
      },
      orElse: () {},
    );

    bloc.add(const AttendanceEvent.checkStatusRequested());
  }

  void _handleStatusLoaded(dynamic status, AppLocalizations l10n) {
    if (!status.success) return;
    if (mounted) {
      setState(() {
        _isPunchedIn = status.punchedIn;
        _isOnBreak = status.onBreak;
        _firstIn = status.firstIn;
        _workedSeconds = status.workedSeconds ?? 0;
        _serverTimeMs = status.serverTimeMs;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _stopPolling();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final baseUrl = AppConstants.baseUrl;

    return BlocListener<AttendanceBloc, AttendanceState>(
      listenWhen: (previous, current) =>
          current.mapOrNull(loaded: (_) => true, error: (_) => true) == true,
      listener: (context, state) {
        state.maybeWhen(
          loaded: (status, logs, calendarEvents, _, __, _, _, _, _, _) {
            _handleStatusLoaded(status, l10n);
          },
          error: (message, events, _, __, _, _, _, _, _) {
            // Error toasts are handled by PunchCard
          },
          orElse: () {},
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppConstants.p16.w),
        padding: EdgeInsets.all(AppConstants.p16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colors.outlineVariant.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Profile Info Section
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                final user = authState.maybeWhen(
                  authenticated: (user) => user,
                  orElse: () => null,
                );
                return BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, profileState) {
                    final profileImage = profileState.maybeWhen(
                      loaded: (profile, resume) => profile.userImage,
                      orElse: () => user?.userImage,
                    );
                    final fullName = profileState.maybeWhen(
                      loaded: (profile, resume) => profile.fullName,
                      orElse: () => user?.fullName,
                    );
                    final designation = profileState.maybeWhen(
                      loaded: (profile, resume) => profile.designation,
                      orElse: () => null,
                    );
                    final empId = profileState.maybeWhen(
                      loaded: (profile, resume) => profile.customPayrollId != null && profile.customPayrollId!.isNotEmpty 
                          ? "${l10n.empPrefix}${profile.customPayrollId}" 
                          : profile.empId,
                      orElse: () => null,
                    );
                    final company = profileState.maybeWhen(
                      loaded: (profile, resume) => profile.company,
                      orElse: () => null,
                    );
                    
                    final displayInitials = fullName?.isNotEmpty == true ? fullName![0].toUpperCase() : "E";

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.primary, // Dark green-ish from mockup
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: (profileImage != null && profileImage.isNotEmpty)
                              ? Image.network(
                                  profileImage.startsWith(AppConstants.httpPrefix)
                                      ? profileImage
                                      : "$baseUrl$profileImage",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Center(
                                    child: Text(
                                      displayInitials,
                                      style: AppTextStyle.bodyLarge.copyWith(color: colors.white),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    displayInitials,
                                    style: AppTextStyle.bodyLarge.copyWith(color: colors.white),
                                  ),
                                ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullName ?? l10n.employeeName,
                                style: AppTextStyle.bodyMedium.copyWith(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: colors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  designation ?? l10n.designation,
                                  style: AppTextStyle.bodySmall.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Wrap(
                                spacing: 8.w,
                                runSpacing: 4.h,
                                children: [
                                  _Badge(
                                    icon: Icon(Icons.business, size: 12.w, color: colors.holidayText),
                                    text: company ?? "", // From API or default to Dhira
                                    backgroundColor: colors.holidayBg,
                                    textColor: colors.holidayText,
                                  ),
                                  _Badge(
                                    icon: Icon(Icons.badge_outlined, size: 12.w, color: colors.holidayText),
                                    text: empId ?? l10n.notAvailable,
                                    backgroundColor: colors.holidayBg,
                                    textColor: colors.holidayText,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            
            SizedBox(height: 16.h),
            PunchCard(padding: EdgeInsets.zero),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const _Badge({
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(width: 4.w),
          Text(
            text,
            style: AppTextStyle.bodySmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
