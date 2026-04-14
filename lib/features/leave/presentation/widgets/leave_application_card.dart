import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/leave_entity.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

import '../screens/apply_leave_screen.dart';

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

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(AppConstants.p16),
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
                        style: AppTextStyle.bodySmall.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        leave.employeeName,
                        style: AppTextStyle.h3.copyWith(fontSize: 16, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                _StatusBadge(status: leave.status, docstatus: leave.docstatus ?? 0),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(Icons.type_specimen_outlined, "Leave Type", leave.leaveType),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.calendar_today_outlined, "Duration", "${leave.fromDate} to ${leave.toDate}"),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.timer_outlined, "Total Days", "${leave.totalLeaveDays} Days"),
            if (leave.leaveApproverName != null) ...[
              const SizedBox(height: 8),
              _buildInfoRow(Icons.person_outline, "Approver", leave.leaveApproverName!),
            ],
            if (hasAnyAction) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showApprovalActions) ...[
                    TextButton.icon(
                      onPressed: () => _onStatusUpdate(context, 'Approved'),
                      icon: const Icon(Icons.check_circle_outline, color: Colors.green),
                      label: const Text("Approve", style: TextStyle(color: Colors.green)),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () => _onStatusUpdate(context, 'Rejected'),
                      icon: const Icon(Icons.highlight_off, color: Colors.red),
                      label: const Text("Reject", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                  const Spacer(),
                  if (showCancel)
                    TextButton.icon(
                      onPressed: () => _onCancel(context),
                      icon: const Icon(Icons.cancel_outlined, color: Colors.orange),
                      label: const Text("Cancel", style: TextStyle(color: Colors.orange)),
                    ),
                  if (showEditDelete) ...[
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                      onPressed: () => _onEdit(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _onDelete(context),
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
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text("$label: ", style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(value, style: AppTextStyle.bodySmall),
        ),
      ],
    );
  }

  void _onStatusUpdate(BuildContext context, String status) {
    context.read<LeaveBloc>().add(LeaveEvent.statusUpdateRequested(
      leaveApplicationName: leave.name,
      newStatus: status,
    ));
    onAction();
  }

  void _onCancel(BuildContext context) {
    context.read<LeaveBloc>().add(LeaveEvent.cancelRequested(leave.name, currentEmpId));
    onAction();
  }

  void _onEdit(BuildContext context) {
    print("edit leave = $currentEmpId, lev =$leave");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplyLeaveScreen(
          employeeId: currentEmpId,
          leave: leave,
        ),
      ),
    ).then((_) {
      onAction();
    });
  }

  void _onDelete(BuildContext context) {
    final leaveBloc = context.read<LeaveBloc>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Leave"),
        content: const Text("Are you sure you want to delete this leave application?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text("No")),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              leaveBloc.add(LeaveEvent.deleteRequested(leave.name, currentEmpId));
              onAction();
            },
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
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
    Color color = Colors.blue;
    
    if (status == 'Approved' || docstatus == 1) {
      color = Colors.green;
    } else if (status == 'Rejected') {
      color = Colors.red;
    } else if (status == 'Cancelled' || docstatus == 2) {
      color = Colors.grey;
    } else if (status == 'Open' || docstatus == 0) {
      color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
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

