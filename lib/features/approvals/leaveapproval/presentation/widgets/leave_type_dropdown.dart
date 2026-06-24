import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/leave_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'leave_form_elements.dart';

class LeaveTypeDropdown extends StatelessWidget {
  final AppLocalizations l10n;
  final LeaveApprovalState state;
  final String? currentLeaveType;
  final String gender;
  final ValueChanged<String?> onChanged;

  const LeaveTypeDropdown({
    super.key,
    required this.l10n,
    required this.state,
    required this.currentLeaveType,
    required this.gender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final filteredLeaveTypes = state.leaveTypes.where((type) {
      final typeName = type.name.toLowerCase();
      final userGender = gender.toLowerCase();
      if (userGender == Gender.male &&
          typeName.contains(LeaveTypes.maternityLeave.toLowerCase())) {
        return false;
      }
      if (userGender == Gender.female &&
          typeName.contains(LeaveTypes.paternityLeave.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeaveLabel(label: l10n.leaveType),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            value: currentLeaveType,
            dropdownColor: colors.surfaceContainerHighest,
            style: AppTextStyle.bodyMedium.copyWith(
              color: colors.onSurface,
            ),
            items: filteredLeaveTypes.map((type) {
              return DropdownMenuItem(
                value: type.name,
                child: Text(
                  type.name,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: colors.onSurface,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: colors.surfaceContainerHighest,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.p16,
                vertical: AppConstants.p18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.r12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.r12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.r12),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.r12),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.r12),
                borderSide: BorderSide.none,
              ),
              errorStyle: AppTextStyle.bodySmall.copyWith(color: colors.error),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            icon: Icon(
              Icons.arrow_drop_down,
              color: colors.outline,
            ),
            validator: (val) => val == null ? l10n.required : null,
          ),
        ),
      ],
    );
  }
}
