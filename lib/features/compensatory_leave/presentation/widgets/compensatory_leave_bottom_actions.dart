import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_bloc.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_event.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_state.dart';

class CompensatoryLeaveBottomActions extends StatelessWidget {
  const CompensatoryLeaveBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: MediaQuery.paddingOf(context).bottom > 0
            ? MediaQuery.paddingOf(context).bottom + 8.h
            : 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        border: Border(
          top: BorderSide(color: AppColors.of(context).border, width: 1.w),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CommonButton(
              text: l10n.cancel,
              variant: ButtonVariant.outlined,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child:
                BlocSelector<
                  CompensatoryLeaveBloc,
                  CompensatoryLeaveState,
                  bool
                >(
                  selector: (state) => state.isActionLoading,
                  builder: (context, isActionLoading) {
                    return CommonButton(
                      text: l10n.submitRequest,
                      isLoading: isActionLoading,
                      onPressed: isActionLoading
                          ? null
                          : () {
                              context.read<CompensatoryLeaveBloc>().add(
                                const CompensatoryLeaveEvent.submitRequested(),
                              );
                            },
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
