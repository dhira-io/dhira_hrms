import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entities.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LeaveTypeSelectionGrid extends StatelessWidget {
  final String? selectedLeaveType;
  final List<LeaveTypeEntity> leaveTypes;
  final LeaveBalanceEntity balance;
  final String gender;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  const LeaveTypeSelectionGrid({
    super.key,
    required this.selectedLeaveType,
    required this.leaveTypes,
    required this.balance,
    required this.gender,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // Filter leave types based on gender
    final filteredTypes = leaveTypes.where((type) {
      if (gender.toLowerCase() == 'male' &&
          type.leaveTypeName.toLowerCase().contains('maternity')) {
        return false;
      } else if (gender.toLowerCase() == 'female' &&
          type.leaveTypeName.toLowerCase().contains('paternity')) {
        return false;
      }
      return true;
    }).toList();

    return FormField<String>(
      initialValue: selectedLeaveType,
      validator: validator,
      builder: (state) {
        if (selectedLeaveType == null && filteredTypes.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onChanged(filteredTypes.first.name);
            state.didChange(filteredTypes.first.name);
          });
        }
        final l10n = AppLocalizations.of(context)!;

        return LayoutBuilder(
          builder: (context, constraints) {
            double totalAvailable = 0;
            double totalAllocated = 0;
            
            for (var detail in balance.details) {
              totalAvailable += detail.available;
              totalAllocated += detail.allocated;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppConstants.p8.w,
                    mainAxisSpacing: AppConstants.p8.h,
                    mainAxisExtent: 70.h,
                  ),
                  itemCount: filteredTypes.length,
                  itemBuilder: (context, index) {
                    final type = filteredTypes[index];
                    final isSelected = selectedLeaveType == type.name;

                    return GestureDetector(
                      onTap: () {
                        onChanged(type.name);
                        state.didChange(type.name);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: AppConstants.p8.w, vertical: AppConstants.p8.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.of(context).primary.withValues(alpha: 0.05) : AppColors.of(context).transparent,
                          borderRadius: BorderRadius.circular(AppConstants.r8),
                          border: Border.all(
                            color: isSelected ? AppColors.of(context).primary : AppColors.of(context).outlineVariant,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          type.leaveTypeName,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: isSelected ? AppColors.of(context).primary : AppColors.of(context).onSurface,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppConstants.p16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppConstants.p16.w, vertical: AppConstants.p12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.r8),
                    border: Border.all(
                      color: AppColors.of(context).outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.availableBalance,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.of(context).onSurface,
                            ),
                          ),
                          Text(
                            balance.details.isNotEmpty
                                ? "${totalAvailable % 1 == 0 ? totalAvailable.toInt() : totalAvailable}/${totalAllocated % 1 == 0 ? totalAllocated.toInt() : totalAllocated} ${l10n.daysLabel}"
                                : l10n.loading,
                            style: AppTextStyle.labelLarge.copyWith(
                              color: AppColors.of(context).onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.p8),
                      LinearProgressIndicator(
                        value: totalAllocated > 0 
                          ? (totalAllocated - totalAvailable) / totalAllocated 
                          : 0.0,
                        backgroundColor: AppColors.of(context).outlineVariant.withValues(alpha: 0.5),
                        color: AppColors.of(context).primary,
                        minHeight: AppConstants.p8.h,
                        borderRadius: BorderRadius.circular(AppConstants.r4),
                      ),
                    ],
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: EdgeInsets.only(top: AppConstants.p8.h, left: AppConstants.p16.w),
                    child: Text(
                      state.errorText!,
                      style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).error),
                    ),
                  ),
              ],
            );
          }
        );
      },
    );
  }
}
