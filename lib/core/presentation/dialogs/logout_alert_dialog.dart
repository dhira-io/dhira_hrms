import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/bloc/auth_event.dart';
import '../../../l10n/app_localizations.dart';
import '../../theme/app_colors.dart';

class LogoutAlertDialog extends StatelessWidget {
  final bool isForced;
  final String? customTitle;
  final String? customContent;

  const LogoutAlertDialog({
    super.key,
    this.isForced = false,
    this.customTitle,
    this.customContent,
  });

  static Future<void> show(
    BuildContext context, {
    bool isForced = false,
    String? customTitle,
    String? customContent,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: !isForced,
      builder: (context) => LogoutAlertDialog(
        isForced: isForced,
        customTitle: customTitle,
        customContent: customContent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Determine title and content based on whether it's forced (session expired) or standard logout
    final title = customTitle ?? (isForced ? l10n.sessionExpiredTitle : l10n.confirmLogout);
    final content = customContent ?? (isForced 
        ? l10n.sessionExpiredMessage 
        : l10n.logoutConfirmationQuestion);

    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        if (!isForced)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        TextButton(
          onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.forcedLogoutRequested());
              Navigator.pop(context);
          },
          child: Text(
            l10n.logout,
            style: TextStyle(color: AppColors.of(context).error),
          ),
        ),
      ],
    );
  }
}
