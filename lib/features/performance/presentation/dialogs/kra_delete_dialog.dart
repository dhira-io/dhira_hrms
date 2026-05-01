import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/kra_entity.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_event.dart';

class KraDeleteDialog extends StatelessWidget {
  final KraEntity kra;

  const KraDeleteDialog({
    super.key,
    required this.kra,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.deleteKra),
      content: Text(l10n.deleteKraConfirmation),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            context.read<PerformanceBloc>().add(
                  PerformanceEvent.kraDeleted(kra),
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
