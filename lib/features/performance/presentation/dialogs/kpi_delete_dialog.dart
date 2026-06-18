import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_alert_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/kpi_entity.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_event.dart';

class KpiDeleteDialog extends StatelessWidget {
  final KpiEntity kpi;

  const KpiDeleteDialog({super.key, required this.kpi});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CommonAlertDialog(
      title: l10n.deleteKpi,
      content: l10n.deleteKpiConfirmation,
      confirmText: l10n.delete,
      cancelText: l10n.cancel,
      onConfirm: () {
        context.read<PerformanceBloc>().add(PerformanceEvent.kpiDeleted(kpi));
      },
      confirmButtonColor: AppColors.of(context).error,
    );
  }
}
