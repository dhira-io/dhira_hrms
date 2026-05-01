import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/kpi_entity.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_event.dart';

class KpiDeleteDialog extends StatelessWidget {
  final KpiEntity kpi;

  const KpiDeleteDialog({
    super.key,
    required this.kpi,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.deleteKpi),
      content: Text(l10n.deleteKpiConfirmation),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            context.read<PerformanceBloc>().add(
                  PerformanceEvent.kpiDeleted(kpi),
                );
            Navigator.pop(context);
          },
          child: Text(
            l10n.delete,
            style: const TextStyle(
              color: AppColors.error,
            ),
          ),
        ),
      ],
    );
  }
}
