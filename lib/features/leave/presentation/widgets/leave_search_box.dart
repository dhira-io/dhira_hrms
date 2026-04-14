import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';

class LeaveSearchBox extends StatelessWidget {
  final TextEditingController controller;

  const LeaveSearchBox({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) => previous.searchQuery != current.searchQuery,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          color: AppColors.primary,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                context.read<LeaveBloc>().add(LeaveEvent.searchChanged(value));
              },
              decoration: InputDecoration(
                hintText: l10n.searchEmployeeLeaveType,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          controller.clear();
                          context.read<LeaveBloc>().add(LeaveEvent.searchChanged(''));
                        },
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
