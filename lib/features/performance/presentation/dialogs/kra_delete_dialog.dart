import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_alert_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/kra_entity.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_event.dart';

class KraDeleteDialog extends StatelessWidget {
  final KraEntity kra;

  const KraDeleteDialog({super.key, required this.kra});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CommonAlertDialog(
      title: l10n.deleteKra,
      content: l10n.deleteKraConfirmation,
      confirmText: l10n.delete,
      cancelText: l10n.cancel,
      onConfirm: () {
        context.read<PerformanceBloc>().add(
              PerformanceEvent.kraDeleted(kra),
            );
      },
      confirmButtonColor: AppColors.of(context).error,
    );
  }
}
