import 'package:dhira_hrms/core/constants/app_constants.dart';
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
          padding: const EdgeInsets.all(AppConstants.p12),
          color: AppColors.primary,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppConstants.r8),
            ),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                context.read<LeaveBloc>().add(LeaveEvent.searchChanged(value));
              },
              decoration: InputDecoration(
                hintText: l10n.searchEmployeeLeaveType,
                prefixIcon: const Icon(Icons.search, color: AppColors.placeholdergrey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: AppConstants.p12),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppColors.placeholdergrey),
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
