import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/bloc/auth_event.dart';
import '../../../l10n/app_localizations.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common_alert_dialog.dart';

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

    return CommonAlertDialog(
      title: title,
      content: content,
      confirmText: l10n.logout,
      cancelText: isForced ? null : l10n.cancel,
      onConfirm: () {
        context.read<AuthBloc>().add(const AuthEvent.forcedLogoutRequested());
      },
      confirmButtonColor: AppColors.of(context).error,
    );
  }
}
