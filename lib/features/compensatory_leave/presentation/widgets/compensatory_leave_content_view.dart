import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_bloc.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_state.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/widgets/compensatory_leave_summary_section.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/widgets/compensatory_leave_form_section.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/widgets/compensatory_leave_skeleton.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/widgets/compensatory_leave_bottom_actions.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/widgets/compensatory_leave_error_view.dart';

class CompensatoryLeaveContentView extends StatelessWidget {
  const CompensatoryLeaveContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CompensatoryLeaveBloc, CompensatoryLeaveState>(
      buildWhen: (prev, curr) =>
          (prev.summary == null) != (curr.summary == null) ||
          (prev.status == CompensatoryLeaveStatus.failure &&
                  prev.summary == null) !=
              (curr.status == CompensatoryLeaveStatus.failure &&
                  curr.summary == null) ||
          (prev.status == CompensatoryLeaveStatus.loading &&
                  prev.summary == null) !=
              (curr.status == CompensatoryLeaveStatus.loading &&
                  curr.summary == null),
      builder: (context, state) {
        if (state.status == CompensatoryLeaveStatus.loading ||
            state.status == CompensatoryLeaveStatus.initial) {
          if (state.summary == null) {
            return const CompensatoryLeaveSkeleton();
          }
        }

        if (state.status == CompensatoryLeaveStatus.failure &&
            state.summary == null) {
          return CompensatoryLeaveErrorView(errorMessage: state.errorMessage);
        }

        if (state.summary == null) return const SizedBox.shrink();

        return Column(
          children: [
            // Info Banner
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              color: AppColors.of(context).infoBg,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.of(context).info,
                    size: AppConstants.iconXSmall.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      l10n.compensatoryLeaveInfo,
                      style: AppTextStyle.labelLarge.copyWith(
                        color: AppColors.of(context).info,
                        fontSize: AppConstants.fs9.sp,
                        height: 1.3.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      CompensatoryLeaveSummarySection(),
                      SizedBox(height: 10.h),
                      CompensatoryLeaveFormSection(),
                    ],
                  ),
                ),
              ),
            ),
            // Footer Actions
            const CompensatoryLeaveBottomActions(),
          ],
        );
      },
    );
  }
}
