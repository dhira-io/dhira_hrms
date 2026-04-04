import 'package:flutter/cupertino.dart';
import '../../core/theme/app_text_style.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class AppDialogs {
  static void showAlertDialog(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            l10n.appTitle,
            style: AppTextStyle.h3.copyWith(fontSize: 14),
          ),
          content: Text(
            message,
            style: AppTextStyle.bodyMedium,
            maxLines: 3,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                l10n.ok,
                style: AppTextStyle.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

