import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../bloc/attendance_bloc.dart';
import '../bottom_sheets/leave_policy_pdf_bottom_sheet.dart';
import '../bottom_sheets/holiday_list_bottom_sheet.dart';

class AttendanceHeader extends StatefulWidget {
  const AttendanceHeader({super.key});

  @override
  State<AttendanceHeader> createState() => _AttendanceHeaderState();
}

class _AttendanceHeaderState extends State<AttendanceHeader> {
  bool _showPolicyPending = false;
  bool _showHolidayListPending = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<AttendanceBloc, AttendanceState>(
      listenWhen: (previous, current) =>
          previous.holidayListLeavePolicy != current.holidayListLeavePolicy ||
          current.mapOrNull(error: (_) => true) == true,
      listener: (context, state) {
        final isLoading = state.mapOrNull(loading: (_) => true) ?? false;
        final hasError = state.mapOrNull(error: (_) => true) ?? false;

        if (state.holidayListLeavePolicy != null && !isLoading && !hasError) {
          if (_showPolicyPending) {
            _showPolicyPending = false;
            LeavePolicyPdfBottomSheet.show(
              context,
              state.holidayListLeavePolicy!.leavePolicy.fileUrl,
            );
          }
          if (_showHolidayListPending) {
            _showHolidayListPending = false;
            HolidayListBottomSheet.showYearly(
              context,
              state.holidayListLeavePolicy!,
            );
          }
        }

        if (hasError) {
          _showPolicyPending = false;
          _showHolidayListPending = false;
        }
      },
      child: Container(
        width: double.infinity,
        color: AppColors.of(context).background,
        padding: const EdgeInsets.only(
          left: AppConstants.p20,
          right: AppConstants.p20,
          top: AppConstants.p10,
          bottom: AppConstants.p15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   l10n.calendar,
            //   style: AppTextStyle.h1.copyWith(
            //     fontSize: AppConstants.fs32,
            //     fontWeight: FontWeight.w800,
            //     color: AppColors.of(context).textPrimary,
            //   ),
            // ),
            SizedBox(height: 10.h),

            // Action Chips
            Row(
              children: [
                BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                    final isLoading =
                        state.mapOrNull(loading: (s) => s.actionType) ==
                        AttendanceActionType.fetchPolicy;

                    return Row(
                      children: [
                        _ActionChip(
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
                                      state
                                          .holidayListLeavePolicy!
                                          .leavePolicy
                                          .fileUrl,
                                    );
                                  } else {
                                    setState(() {
                                      _showPolicyPending = true;
                                    });
                                    context.read<AttendanceBloc>().add(
                                      const AttendanceEvent.holidayListLeavePolicyRequested(),
                                    );
                                  }
                                },
                        ),
                        SizedBox(width: 12.w),
                        _ActionChip(
                          icon: Icons.list_alt,
                          label: l10n.holidayList,
                          onTap: () {
                            if (state.holidayListLeavePolicy != null) {
                              HolidayListBottomSheet.showYearly(
                                context,
                                state.holidayListLeavePolicy!,
                              );
                            } else {
                              setState(() {
                                _showHolidayListPending = true;
                              });
                              context.read<AttendanceBloc>().add(
                                const AttendanceEvent.holidayListLeavePolicyRequested(),
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
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.of(context).slate200,
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
                color: AppColors.of(context).onSurfaceVariant,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: AppTextStyle.label.copyWith(
                  color: AppColors.of(context).onSurfaceVariant,
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
