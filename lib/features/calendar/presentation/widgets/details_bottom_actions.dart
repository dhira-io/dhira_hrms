import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_bloc.dart';

class DetailsBottomActions extends StatelessWidget {
  const DetailsBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            final selectedDay = context.read<CalendarBloc>().state.selectedDay;
            context.push(
              AppRouter.attendanceRegularizationPath,
              extra: {'preselectedDate': selectedDay},
            );
          },
          child: Container(
            height: 36.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: colors.tableBorder, width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: colors.black.withValues(alpha: 0.05),
                  blurRadius: 2.r,
                  offset: Offset(0, 1.h),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              l10n.attendanceRegularization,
              style: AppTextStyle.labelLarge.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            final state = context.read<CalendarBloc>().state;
            final empId = state.employeeId ?? '';
            final selectedDay = state.selectedDay;
            context.push(
              AppRouter.applyLeavePath,
              extra: {
                AppRouter.argEmployeeId: empId,
                'preselectedDate': selectedDay,
              },
            );
          },
          child: Container(
            height: 36.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              l10n.applyLeaveBtn,
              style: AppTextStyle.labelLarge.copyWith(
                color: colors.surfaceContainerLowest,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
