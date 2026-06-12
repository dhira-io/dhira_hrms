import 'package:dhira_hrms/core/widgets/common_alert_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

void showPunchOutDialog({
  required BuildContext context,
  required int Function() getWorkedSeconds,
  required VoidCallback onConfirm,
}) {
  final l10n = AppLocalizations.of(context)!;

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (sbContext, snapshot) {
          final currentTotal = Duration(seconds: getWorkedSeconds());
          final formattedTime = formatDuration(currentTotal);
          final isLess = currentTotal.inMinutes < (9 * 60 + 30);
          final title = isLess ? l10n.punchOutEarlyWarning : l10n.confirmLogout;

          return CommonAlertDialog(
            title: title,
            content: l10n.punchOutConfirmation(formattedTime),
            confirmText: l10n.yesLogOut,
            cancelText: l10n.cancel,
            onConfirm: onConfirm,
          );
        },
      );
    },
  );
}
