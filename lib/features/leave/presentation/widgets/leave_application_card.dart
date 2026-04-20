import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/leave_constants.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/leave_entity.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class LeaveApplicationCard extends StatelessWidget {
  final LeaveEntity leave;
  final VoidCallback onAction;

  const LeaveApplicationCard({
    super.key,
    required this.leave,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.p8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leave.name,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        leave.employeeName,
                        style: AppTextStyle.h3.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                _StatusBadge(status: leave.status, docstatus: leave.docstatus ?? 0),
              ],
            ),
            const Divider(height: AppConstants.p24),
            _buildInfoRow(Icons.type_specimen_outlined, l10n.leaveType, leave.leaveType),
            const SizedBox(height: AppConstants.p8),
            _buildInfoRow(Icons.calendar_today_outlined, l10n.duration, "${leave.fromDate} to ${leave.toDate}"),
            const SizedBox(height: AppConstants.p8),
            _buildInfoRow(Icons.timer_outlined, l10n.total, l10n.daysCount(leave.totalLeaveDays ?? 0)),
            if (leave.leaveApproverName != null) ...[
              const SizedBox(height: AppConstants.p8),
              _buildInfoRow(Icons.person_outline, l10n.approver, leave.leaveApproverName!),
            ],
            if (leave.showCancel || leave.showEditDelete) ...[
              const SizedBox(height: AppConstants.p16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (leave.showCancel)
                    TextButton.icon(
                      onPressed: () => _onCancel(context),
                      icon: const Icon(Icons.cancel_outlined, color: AppColors.warning),
                      label: Text(l10n.cancel, style: const TextStyle(color: AppColors.warning)),
                    ),
                  if (leave.showEditDelete) ...[
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: AppColors.secondary),
                      onPressed: () => _onEdit(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppColors.error),
                      onPressed: () => _onDelete(context, l10n),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: AppConstants.iconSmall, color: AppColors.textSecondary),
        const SizedBox(width: AppConstants.p8),
        Text("$label: ", style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(value, style: AppTextStyle.bodySmall),
        ),
      ],
    );
  }

  void _onCancel(BuildContext context) {
    final state = context.read<LeaveBloc>().state;
    context.read<LeaveBloc>().add(LeaveEvent.cancelRequested(leave.name, state.currentEmpId));
    onAction();
  }

  void _onEdit(BuildContext context) {
    final state = context.read<LeaveBloc>().state;
    context.push(
      AppRouter.applyLeavePath,
      extra: {
        'employeeId': state.currentEmpId,
        'leave': leave,
      },
    ).then((_) {
      if (context.mounted) {
        onAction();
      }
    });
  }

  void _onDelete(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => _DeleteLeaveDialog(
        leaveName: leave.name,
        onConfirm: () {
          final state = context.read<LeaveBloc>().state;
          context.read<LeaveBloc>().add(LeaveEvent.deleteRequested(leave.name, state.currentEmpId));
          onAction();
        },
      ),
    );
  }
}

class _DeleteLeaveDialog extends StatelessWidget {
  final String leaveName;
  final VoidCallback onConfirm;

  const _DeleteLeaveDialog({
    required this.leaveName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.deleteLeave),
      content: Text(l10n.deleteLeaveWarning),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.no),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(l10n.yes, style: const TextStyle(color: AppColors.error)),
        ),
      ],
    );
  }
}


class _StatusBadge extends StatelessWidget {
  final String status;
  final int docstatus;
  const _StatusBadge({required this.status, required this.docstatus});

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.secondary;

    if (status == LeaveStatusConstants.approved || docstatus == LeaveDocStatus.submitted) {
      color = AppColors.success;
    } else if (status == LeaveStatusConstants.rejected) {
      color = AppColors.error;
    } else if (status == LeaveStatusConstants.cancelled || docstatus == LeaveDocStatus.cancelled) {
      color = AppColors.textSecondary;
    } else if (status == LeaveStatusConstants.open || docstatus == LeaveDocStatus.draft) {
      color = AppColors.warning;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p10,
        vertical: AppConstants.p4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.r20),
      ),
      child: Text(
        status,
        style: AppTextStyle.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

