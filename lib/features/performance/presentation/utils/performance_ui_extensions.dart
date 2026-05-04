import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/team_evaluation_entity.dart';

extension TeamEvaluationEntityX on TeamEvaluationEntity {
  String get statusLabel => docstatus == 1 ? 'Submitted' : 'Pending';
  
  Color get statusColor {
    switch (statusLabel.toLowerCase()) {
      case 'submitted':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  Color get statusBgColor {
    switch (statusLabel.toLowerCase()) {
      case 'submitted':
        return AppColors.successBg;
      case 'pending':
        return AppColors.warningBg;
      default:
        return AppColors.slate100;
    }
  }
}
