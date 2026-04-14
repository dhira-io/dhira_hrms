import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_style.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';

class LeaveSummaryHeader extends StatelessWidget {
  const LeaveSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) => previous.balance != current.balance,
      builder: (context, state) {
        final balance = state.balance;

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryItem(label: "Total", value: '${balance.totalAllocated}', color: AppColors.primary),
              _SummaryItem(label: "Used", value: '${balance.used}', color: Colors.orange),
              _SummaryItem(label: "Pending", value: '${balance.pending}', color: Colors.purple),
              _SummaryItem(label: "Available", value: '${balance.available}', color: Colors.green),
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

