import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../domain/entities/leave_type_entity.dart';
import '../../../../../core/constants/leave_constants.dart';

class LeaveTypeDropdown extends StatelessWidget {
  final String? value;
  final List<LeaveTypeEntity> leaveTypes;
  final String gender;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const LeaveTypeDropdown({
    super.key,
    required this.value,
    required this.leaveTypes,
    required this.gender,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final userGender = gender.toLowerCase();

    final filteredTypes = leaveTypes.where((type) {
      final typeName = type.name.toLowerCase();
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

    return DropdownButtonFormField<String>(
      initialValue: value,
      dropdownColor: AppColors.of(context).surfaceContainerHighest,
      style: AppTextStyle.bodyMedium.copyWith(
        color: AppColors.of(context).onSurface,
      ),
      items: filteredTypes.map((type) {
        return DropdownMenuItem(
          value: type.name,
          child: Text(
            type.name,
            style: AppTextStyle.bodyMedium.copyWith(
              color: AppColors.of(context).onSurface,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.of(context).surfaceContainerHighest,
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
        errorStyle: AppTextStyle.bodySmall.copyWith(color: Colors.red),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Icon(
          Icons.arrow_drop_down,
          color: AppColors.of(context).outline,
        ),
      ),
      validator: validator,
    );
  }
}
