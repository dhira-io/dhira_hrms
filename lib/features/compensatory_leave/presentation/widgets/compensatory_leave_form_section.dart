import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/common_guidelines.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_bloc.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_event.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_state.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_eligible_date_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/constants/compensatory_leave_constants.dart';

class CompensatoryLeaveFormSection extends StatelessWidget {
  const CompensatoryLeaveFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card Box 1: Work Details
        CompensatoryLeaveFormCard(
          children: [
            Text(
              l10n.workDetails,
              style: AppTextStyle.h3.copyWith(
                fontSize: AppConstants.fs12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              l10n.workDetailsSub,
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.of(context).textSecondary,
                fontSize: AppConstants.fs9.sp,
              ),
            ),
            SizedBox(height: 10.h),

            // Work Date Dropdown
            CompensatoryLeaveFormLabel(text: l10n.workDate, isRequired: true),
            SizedBox(height: 8.h),
            BlocBuilder<CompensatoryLeaveBloc, CompensatoryLeaveState>(
              buildWhen: (prev, curr) =>
                  prev.selectedDate != curr.selectedDate ||
                  prev.eligibleDates != curr.eligibleDates,
              builder: (context, state) {
                if (state.eligibleDates.isEmpty) {
                  return TextFormField(
                    initialValue: l10n.noEligibleDates,
                    readOnly: true,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: AppColors.of(context).textSecondary,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.of(context).surfaceContainerLow,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppConstants.p16.w,
                        vertical: AppConstants.p12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: AppColors.of(context).border,
                          width: 1.w,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: AppColors.of(context).border,
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: AppColors.of(context).border,
                          width: 1.w,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.event_busy,
                        color: AppColors.of(
                          context,
                        ).textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                  );
                }

                return DropdownButtonFormField<
                  CompensatoryLeaveEligibleDateEntity
                >(
                  initialValue: state.selectedDate,
                  dropdownColor: AppColors.of(context).surfaceContainerLowest,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.of(context).onSurface,
                  ),
                  hint: Text(
                    l10n.selectEligibleDate,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: AppColors.of(
                        context,
                      ).outline.withValues(alpha: 0.6),
                    ),
                  ),
                  items: state.eligibleDates.map((dateEntity) {
                    return DropdownMenuItem<
                      CompensatoryLeaveEligibleDateEntity
                    >(value: dateEntity, child: Text(dateEntity.displayLabel));
                  }).toList(),
                  onChanged: (selected) {
                    if (selected == null) return;
                    FocusScope.of(context).unfocus();
                    context.read<CompensatoryLeaveBloc>().add(
                      CompensatoryLeaveEvent.dateSelected(selected),
                    );
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.of(context).surfaceContainerLowest,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppConstants.p16.w,
                      vertical: AppConstants.p12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.of(context).border,
                        width: 1.w,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.of(context).border,
                        width: 1.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.of(context).primary,
                        width: 1.w,
                      ),
                    ),
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.of(context).outline,
                  ),
                );
              },
            ),
            SizedBox(height: 6.h),
            Text(
              l10n.eligibleDatesNote,
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.of(context).textSecondary,
                fontSize: AppConstants.fs8.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10.h),

            // Worked Hours (Read-Only)
            CompensatoryLeaveFormLabel(
              text: l10n.workedHours,
              isRequired: true,
            ),
            SizedBox(height: 8.h),
            BlocSelector<CompensatoryLeaveBloc, CompensatoryLeaveState, double>(
              selector: (state) => state.workedHours,
              builder: (context, workedHours) {
                return TextFormField(
                  key: ValueKey(workedHours),
                  initialValue: workedHours > 0
                      ? '$workedHours ${CompensatoryLeaveConstants.hoursUnit}'
                      : '0.0 ${CompensatoryLeaveConstants.hoursUnit}',
                  readOnly: true,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.of(context).textSecondary,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.of(context).surfaceContainerLow,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppConstants.p16.w,
                      vertical: AppConstants.p12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.of(context).border,
                        width: 1.w,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.of(context).border,
                        width: 1.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.of(context).border,
                        width: 1.w,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 6.h),
            Text(
              l10n.autoFillNote,
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.of(context).textSecondary,
                fontSize: AppConstants.fs8.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Card Box 2: Timesheet Details & Reason
        CompensatoryLeaveFormCard(
          children: [
            Row(
              children: [
                Text(
                  l10n.timesheetDetails,
                  style: AppTextStyle.h3.copyWith(
                    fontSize: AppConstants.fs12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            BlocSelector<CompensatoryLeaveBloc, CompensatoryLeaveState, String>(
              selector: (state) => state.timesheetFill,
              builder: (context, timesheetFill) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value:
                                  CompensatoryLeaveConstants.timesheetFillAuto,
                              groupValue: timesheetFill,
                              onChanged: (val) {
                                FocusScope.of(context).unfocus();
                                if (val != null) {
                                  context.read<CompensatoryLeaveBloc>().add(
                                    CompensatoryLeaveEvent.timesheetFillChanged(
                                      val,
                                    ),
                                  );
                                }
                              },
                              activeColor: AppColors.of(context).primary,
                              visualDensity: const VisualDensity(
                                horizontal: -4,
                                vertical: -4,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              l10n.autoFill,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(context).textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 24.w),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: CompensatoryLeaveConstants
                                  .timesheetFillManual,
                              groupValue: timesheetFill,
                              onChanged: (val) {
                                FocusScope.of(context).unfocus();
                                if (val != null) {
                                  context.read<CompensatoryLeaveBloc>().add(
                                    CompensatoryLeaveEvent.timesheetFillChanged(
                                      val,
                                    ),
                                  );
                                }
                              },
                              activeColor: AppColors.of(context).primary,
                              visualDensity: const VisualDensity(
                                horizontal: -4,
                                vertical: -4,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              l10n.enterManually,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(context).textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (timesheetFill ==
                        CompensatoryLeaveConstants.timesheetFillManual) ...[
                      SizedBox(height: 10.h),
                      CompensatoryLeaveFormLabel(
                        text: l10n.project,
                        isRequired: true,
                      ),
                      SizedBox(height: 8.h),
                      BlocBuilder<
                        CompensatoryLeaveBloc,
                        CompensatoryLeaveState
                      >(
                        buildWhen: (prev, curr) =>
                            prev.projects != curr.projects ||
                            prev.selectedProject != curr.selectedProject,
                        builder: (context, state) {
                          return DropdownButtonFormField<ProjectEntity>(
                            isExpanded: true,
                            isDense: false,
                            initialValue: state.selectedProject,
                            dropdownColor: AppColors.of(
                              context,
                            ).surfaceContainerLowest,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.of(context).onSurface,
                            ),
                            hint: Text(
                              l10n.selectProject,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.of(
                                  context,
                                ).outline.withValues(alpha: 0.6),
                              ),
                            ),
                            items: state.projects.map((project) {
                              return DropdownMenuItem(
                                value: project,
                                child: Text(project.projectName),
                              );
                            }).toList(),
                            onChanged: (selected) {
                              FocusScope.of(context).unfocus();
                              context.read<CompensatoryLeaveBloc>().add(
                                CompensatoryLeaveEvent.projectSelected(
                                  selected,
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: AppColors.of(
                                context,
                              ).surfaceContainerLowest,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppConstants.p16.w,
                                vertical: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.of(context).border,
                                  width: 1.w,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.of(context).border,
                                  width: 1.w,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.of(context).primary,
                                  width: 1.w,
                                ),
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.of(context).outline,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      CompensatoryLeaveFormLabel(
                        text: l10n.taskWorkDescription,
                        isRequired: true,
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        initialValue: context
                            .read<CompensatoryLeaveBloc>()
                            .state
                            .taskDescription,
                        onChanged: (val) {
                          context.read<CompensatoryLeaveBloc>().add(
                            CompensatoryLeaveEvent.taskDescriptionChanged(val),
                          );
                        },
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppColors.of(context).onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: l10n.taskWorkDescriptionHint,
                          hintStyle: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.of(
                              context,
                            ).outline.withValues(alpha: 0.5),
                          ),
                          filled: true,
                          fillColor: AppColors.of(
                            context,
                          ).surfaceContainerLowest,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.p16.w,
                            vertical: AppConstants.p12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.of(context).border,
                              width: 1.w,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.of(context).border,
                              width: 1.w,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.of(context).primary,
                              width: 1.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
            SizedBox(height: 12.h),
            Text(
              l10n.timesheetAutoFillInfo,
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.of(context).primary,
                fontSize: AppConstants.fs9.sp,
              ),
            ),
            SizedBox(height: 10.h),

            // Reason Section
            BlocSelector<CompensatoryLeaveBloc, CompensatoryLeaveState, String>(
              selector: (state) => state.timesheetFill,
              builder: (context, timesheetFill) {
                return CompensatoryLeaveFormLabel(
                  text: l10n.reasonExtraWork,
                  isRequired: true,
                );
              },
            ),
            SizedBox(height: 8.h),
            TextFormField(
              initialValue: context.read<CompensatoryLeaveBloc>().state.reason,
              maxLines: 3,
              onChanged: (val) {
                context.read<CompensatoryLeaveBloc>().add(
                  CompensatoryLeaveEvent.reasonChanged(val),
                );
              },
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).onSurface,
              ),
              decoration: InputDecoration(
                hintText: l10n.reasonExtraWorkHint,
                hintStyle: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.of(context).outline.withValues(alpha: 0.5),
                ),
                filled: true,
                fillColor: AppColors.of(context).surfaceContainerLowest,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppConstants.p16.w,
                  vertical: AppConstants.p12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: AppColors.of(context).border,
                    width: 1.w,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: AppColors.of(context).border,
                    width: 1.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: AppColors.of(context).primary,
                    width: 1.w,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // Card Box 3: Work Type
        CompensatoryLeaveFormCard(
          children: [
            Text(
              l10n.workType,
              style: AppTextStyle.h3.copyWith(
                fontSize: AppConstants.fs12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            BlocSelector<CompensatoryLeaveBloc, CompensatoryLeaveState, String>(
              selector: (state) => state.workType,
              builder: (context, workType) {
                return Column(
                  children: [
                    CompensatoryLeaveFormSelectionCard(
                      title: l10n.weekendWork,
                      subtitle: l10n.weekendWorkSub,
                      isSelected:
                          workType ==
                          CompensatoryLeaveConstants.workTypeWeekend,
                      value: CompensatoryLeaveConstants.workTypeWeekend,
                      selectedValue: workType,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.read<CompensatoryLeaveBloc>().add(
                          CompensatoryLeaveEvent.workTypeChanged(
                            CompensatoryLeaveConstants.workTypeWeekend,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    CompensatoryLeaveFormSelectionCard(
                      title: l10n.holidayWork,
                      subtitle: l10n.holidayWorkSub,
                      isSelected:
                          workType ==
                          CompensatoryLeaveConstants.workTypeHoliday,
                      value: CompensatoryLeaveConstants.workTypeHoliday,
                      selectedValue: workType,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.read<CompensatoryLeaveBloc>().add(
                          CompensatoryLeaveEvent.workTypeChanged(
                            CompensatoryLeaveConstants.workTypeHoliday,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    CompensatoryLeaveFormSelectionCard(
                      title: l10n.overtimeWork,
                      subtitle: l10n.overtimeWorkSub,
                      isSelected:
                          workType ==
                          CompensatoryLeaveConstants.workTypeOvertime,
                      value: CompensatoryLeaveConstants.workTypeOvertime,
                      selectedValue: workType,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.read<CompensatoryLeaveBloc>().add(
                          CompensatoryLeaveEvent.workTypeChanged(
                            CompensatoryLeaveConstants.workTypeOvertime,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Guidelines list
        CommonGuidelines(
          title: l10n.compOffGuidelines,
          items: [
            l10n.compOffGuideline1,
            l10n.compOffGuideline2,
            l10n.compOffGuideline3,
            l10n.compOffGuideline4,
            l10n.compOffGuideline5,
          ],
        ),
      ],
    );
  }
}

class CompensatoryLeaveFormCard extends StatelessWidget {
  final List<Widget> children;

  const CompensatoryLeaveFormCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.of(context).border, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class CompensatoryLeaveFormLabel extends StatelessWidget {
  final String text;
  final bool isRequired;

  const CompensatoryLeaveFormLabel({
    super.key,
    required this.text,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyle.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.of(context).textPrimary,
        ),
        children: [
          if (isRequired)
            TextSpan(
              text: ' *',
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).error,
              ),
            ),
        ],
      ),
    );
  }
}

class CompensatoryLeaveFormSelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final String value;
  final String selectedValue;
  final VoidCallback onTap;

  const CompensatoryLeaveFormSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.value,
    required this.selectedValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.of(context).infoBg
              : AppColors.of(context).surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? AppColors.of(context).primary
                : AppColors.of(context).border,
            width: isSelected ? 1.5.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: selectedValue,
              onChanged: (_) => onTap(),
              activeColor: AppColors.of(context).primary,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).textSecondary,
                        fontSize: AppConstants.fs8.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
