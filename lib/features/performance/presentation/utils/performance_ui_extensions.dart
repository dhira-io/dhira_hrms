import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/team_evaluation_entity.dart';

extension TeamEvaluationEntityX on TeamEvaluationEntity {
  String get statusLabel => docstatus == 1 ? 'Submitted' : 'Pending';

  String localizedStatusLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return docstatus == 1 ? l10n.submittedStatus : l10n.pendingStatus;
  }

  Color get statusColor {
    switch (docstatus) {
      case 1:
        return AppColors.success;
      case 0:
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  Color get statusBgColor {
    switch (docstatus) {
      case 1:
        return AppColors.successBg;
      case 0:
        return AppColors.warningBg;
      default:
        return AppColors.slate100;
    }
  }
}
