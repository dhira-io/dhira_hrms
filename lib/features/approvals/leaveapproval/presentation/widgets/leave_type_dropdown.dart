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
    final filteredLeaveTypes = state.leaveTypes.where((type) {
      final typeName = type.name.toLowerCase();
      final userGender = gender.toLowerCase();
      if (userGender == 'male' &&
          typeName.contains(LeaveTypes.maternityLeave.toLowerCase())) {
        return false;
      }
      if (userGender == 'female' &&
          typeName.contains(LeaveTypes.paternityLeave.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeaveLabel(label: l10n.leaveType),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppConstants.r12),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: currentLeaveType,
              items: filteredLeaveTypes.map((type) {
                return DropdownMenuItem(
                  value: type.name,
                  child: Text(type.name, style: AppTextStyle.bodyMedium),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
              validator: (val) => val == null ? l10n.required : null,
            ),
          ),
        ),
      ],
    );
  }
}
