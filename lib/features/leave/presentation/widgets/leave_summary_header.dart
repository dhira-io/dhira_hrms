import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';

class LeaveSummaryHeader extends StatelessWidget {
  const LeaveSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocSelector<LeaveBloc, LeaveState, dynamic>(
      selector: (state) {
        return state.maybeWhen(
          loaded: (_, __, balance, ___, ____) => balance,
          orElse: () => null,
        );
      },
      builder: (context, balance) {
        if (balance == null) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(AppConstants.p20),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryItem(label: l10n.total, value: '${balance.totalAllocated}', color: Colors.blue),
              _SummaryItem(label: l10n.used, value: '${balance.used}', color: Colors.orange),
              _SummaryItem(label: l10n.pending, value: '${balance.pending}', color: Colors.purple),
              _SummaryItem(label: l10n.available, value: '${balance.available}', color: Colors.green),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyle.h3.copyWith(color: color),
        ),
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

