import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/attendance/presentation/widgets/leave_details_section.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../bottom_sheets/holiday_list_bottom_sheet.dart';
import '../bottom_sheets/leave_policy_pdf_bottom_sheet.dart';
import '../widgets/attendance_log_list.dart';
import '../widgets/leave_history_section.dart';
import '../widgets/on_leave_today_section.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Pending flags (previously in AttendanceHeader)
  bool _showPolicyPending = false;
  bool _showHolidayListPending = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AttendanceBloc>().add(const AttendanceEvent.started());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        // Error toast listener
        BlocListener<AttendanceBloc, AttendanceState>(
          listenWhen: (previous, current) =>
              current.mapOrNull(error: (_) => true) == true,
          listener: (context, state) {
            state.whenOrNull(
              error: (message, events, _, _, _, _, _, _, _) =>
                  ToastUtils.showError(message),
            );
          },
        ),
        // Leave policy / holiday list pending listener (previously in AttendanceHeader)
        BlocListener<AttendanceBloc, AttendanceState>(
          listenWhen: (previous, current) =>
              previous.holidayListLeavePolicy != current.holidayListLeavePolicy ||
              current.mapOrNull(error: (_) => true) == true,
          listener: (context, state) {
            final isLoading = state.mapOrNull(loading: (_) => true) ?? false;
            final hasError = state.mapOrNull(error: (_) => true) ?? false;

            if (state.holidayListLeavePolicy != null && !isLoading && !hasError) {
              if (_showPolicyPending) {
                setState(() => _showPolicyPending = false);
                LeavePolicyPdfBottomSheet.show(
                  context,
                  state.holidayListLeavePolicy!.leavePolicy.fileUrl,
                );
              }
              if (_showHolidayListPending) {
                setState(() => _showHolidayListPending = false);
                HolidayListBottomSheet.showYearly(
                  context,
                  state.holidayListLeavePolicy!,
                );
              }
            }

            if (hasError) {
              setState(() {
                _showPolicyPending = false;
                _showHolidayListPending = false;
              });
            }
          },
        ),
        // Tab switch refresh listener
        BlocListener<BottomNavCubit, int>(
          listener: (context, state) {
            if (state == BottomNavCubit.attendanceIndex) {
              if (context.mounted) {
                context
                    .read<AttendanceBloc>()
                    .add(const AttendanceEvent.started());
              }
            }
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title + action chips (previously AttendanceHeader)
          Padding(
            padding: const EdgeInsets.only(
              left: AppConstants.p20,
              right: AppConstants.p20,
              top: AppConstants.p10,
              bottom: AppConstants.p15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  l10n.calendar,
                  style: AppTextStyle.h1.copyWith(
                    fontSize: AppConstants.fs32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                    final isLoading =
                        state.mapOrNull(loading: (s) => s.actionType) ==
                            AttendanceActionType.fetchPolicy;

                    return Row(
                      children: [
                        _AttendanceActionChip(
                          icon: isLoading
                              ? Icons.hourglass_empty
                              : Icons.shield_outlined,
                          label: l10n.leavePolicy,
                          onTap: isLoading
                              ? () {}
                              : () {
                                  if (state.holidayListLeavePolicy != null) {
                                    LeavePolicyPdfBottomSheet.show(
                                      context,
                                      state.holidayListLeavePolicy!.leavePolicy
                                          .fileUrl,
                                    );
                                  } else {
                                    setState(
                                        () => _showPolicyPending = true);
                                    context.read<AttendanceBloc>().add(
                                          const AttendanceEvent
                                              .holidayListLeavePolicyRequested(),
                                        );
                                  }
                                },
                        ),
                        const SizedBox(width: 12),
                        _AttendanceActionChip(
                          icon: Icons.list_alt,
                          label: l10n.holidayList,
                          onTap: () {
                            if (state.holidayListLeavePolicy != null) {
                              HolidayListBottomSheet.showYearly(
                                context,
                                state.holidayListLeavePolicy!,
                              );
                            } else {
                              setState(
                                  () => _showHolidayListPending = true);
                              context.read<AttendanceBloc>().add(
                                    const AttendanceEvent
                                        .holidayListLeavePolicyRequested(),
                                  );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Scrollable attendance content
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const AttendanceLogList(),
                  BlocBuilder<AttendanceBloc, AttendanceState>(
                    buildWhen: (previous, current) =>
                        previous.leaveDetails != current.leaveDetails ||
                        previous.leaveHistory != current.leaveHistory ||
                        previous.teamLeaves != current.teamLeaves,
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (state.leaveDetails != null)
                            LeaveDetailsSection(
                              key: ValueKey(
                                state.leaveDetails!.leaveAllocation.length,
                              ),
                              details: state.leaveDetails!,
                            ),
                          if (state.leaveHistory != null)
                            LeaveHistorySection(
                              history: state.leaveHistory!,
                            ),
                          OnLeaveTodaySection(leaves: state.teamLeaves),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Action chip used in the attendance section header.
/// Extracted from the former AttendanceHeader widget.
class _AttendanceActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AttendanceActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.slate200,
      borderRadius: BorderRadius.circular(AppConstants.r12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.p16,
            vertical: AppConstants.p10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: AppConstants.iconSmall,
                color: AppColors.slate600,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyle.label.copyWith(
                  color: AppColors.slate600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
