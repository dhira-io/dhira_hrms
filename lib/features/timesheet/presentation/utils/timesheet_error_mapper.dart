import 'package:dhira_hrms/l10n/app_localizations.dart';

extension TimesheetErrorMapper on String {
  String toLocalizedError(AppLocalizations l10n) {
    return switch (this) {
      "selectProjectValidation" => l10n.selectProjectValidation,
      "taskValidation" => l10n.taskValidation,
      "expectedHoursValidation" => l10n.expectedHoursValidation,
      "actualHoursValidation" => l10n.actualHoursValidation,
      "descriptionValidation" => l10n.descriptionValidation,
      "noChangesDone" => l10n.noChangesDone,
      _ => this,
    };
  }
}
