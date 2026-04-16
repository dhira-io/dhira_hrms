import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_type_entity.dart';
import 'package:flutter/material.dart';
import '../../../../shared/components/mandatory_label.dart';

class LeaveTypeDropdown extends StatelessWidget {
  final String? value;
  final List<LeaveTypeEntity> leaveTypes;
  final ValueChanged<String?> onChanged;

  const LeaveTypeDropdown({
    super.key,
    required this.value,
    required this.leaveTypes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MandatoryLabel(labelText: l10n.leaveType),
        const SizedBox(height: AppConstants.p8),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(l10n.leaveType, style: AppTextStyle.bodyMedium),
          items: leaveTypes.map<DropdownMenuItem<String>>((type) {
            return DropdownMenuItem<String>(
              value: type.leaveTypeName,
              child: Text(type.leaveTypeName, style: AppTextStyle.bodyMedium),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p12,
              vertical: AppConstants.p12,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
          ),
          validator: (val) => val == null ? l10n.required : null,
        ),
      ],
    );
  }
}
