import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';

class LeaveSummaryHeader extends StatelessWidget {
  const LeaveSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LeaveBloc, LeaveState, dynamic>( // Using dynamic for BalanceRecord for simplicity
      selector: (state) {
        return state.maybeWhen(
          loaded: (_, __, balance, ___, ____) => balance,
          orElse: () => null,
        );
      },
      builder: (context, balance) {
        if (balance == null) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryItem(label: 'Total', value: '${balance.totalAllocated}', color: Colors.blue),
              _SummaryItem(label: 'Used', value: '${balance.used}', color: Colors.orange),
              _SummaryItem(label: 'Pending', value: '${balance.pending}', color: Colors.purple),
              _SummaryItem(label: 'Available', value: '${balance.available}', color: Colors.green),
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
