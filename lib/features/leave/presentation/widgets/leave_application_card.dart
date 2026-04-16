import 'package:dhira_hrms/core/constants/app_constants.dart';
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
  final String currentEmpId;
  final String userEmail;
  final VoidCallback onAction;

  const LeaveApplicationCard({
    super.key,
    required this.leave,
    required this.currentEmpId,
    required this.userEmail,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool isMyLeave = leave.employee == currentEmpId;
    final bool isApprover = leave.leaveApprover?.toLowerCase() == userEmail.toLowerCase();

    // Condition 1: Delete and Edit
    final bool showEditDelete = leave.docstatus == 0 && isMyLeave && leave.status == 'Open';

    // Condition 2: Cancel
    final parsedFromDate = DateTime.tryParse(leave.fromDate);
    final bool showCancel = leave.docstatus == 1 &&
        parsedFromDate != null &&
        parsedFromDate.isAfter(DateTime.now());

    // Condition 3: Reject and Approve
    final bool showApprovalActions = isApprover && leave.docstatus == 0;

    final bool hasAnyAction = showEditDelete || showCancel || showApprovalActions;

    // Logic for showing buttons based on status and roles
    final bool isOpen = leave.docstatus == 0;
    final bool isCancelled = leave.status == 'Cancelled';

    // Assuming we have knowledge if the user is an approver.
    // In the legacy code, it checked data[0].leaveapprover which we have in the model.

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
            if (hasAnyAction) ...[
              const SizedBox(height: AppConstants.p16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showCancel)
                    TextButton.icon(
                      onPressed: () => _onCancel(context),
                      icon: const Icon(Icons.cancel_outlined, color: AppColors.warning),
                      label: Text(l10n.cancel, style: const TextStyle(color: AppColors.warning)),
                    ),
                  if (showEditDelete) ...[
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
    context.read<LeaveBloc>().add(LeaveEvent.cancelRequested(leave.name, currentEmpId));
    onAction();
  }

  void _onEdit(BuildContext context) {
    context.push(
      AppRouter.applyLeavePath,
      extra: {
        'employeeId': currentEmpId,
        'leave': leave,
      },
    ).then((_) {
      if (context.mounted) {
        onAction();
      }
    });
  }

  void _onDelete(BuildContext context, AppLocalizations l10n) {
    final leaveBloc = context.read<LeaveBloc>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteLeave),
        content: Text(l10n.deleteLeaveWarning),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text(l10n.no)),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              leaveBloc.add(LeaveEvent.deleteRequested(leave.name, currentEmpId));
              onAction();
            },
            child: Text(l10n.yes, style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
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

    if (status == 'Approved' || docstatus == 1) {
      color = AppColors.success;
    } else if (status == 'Rejected') {
      color = AppColors.error;
    } else if (status == 'Cancelled' || docstatus == 2) {
      color = AppColors.textSecondary;
    } else if (status == 'Open' || docstatus == 0) {
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

