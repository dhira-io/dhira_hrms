import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/entities/approval_type.dart';

class ApprovalCard extends StatelessWidget {
  final ApprovalRequestEntity data;

  const ApprovalCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      margin: const EdgeInsets.only(bottom: AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppConstants.p16),
          _buildDetailsBox(context),
          const SizedBox(height: AppConstants.p16),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.surfaceContainerHigh,
          backgroundImage: data.profileImage != null ? NetworkImage(data.profileImage!) : null,
          child: data.profileImage == null ? const Icon(Icons.person, color: AppColors.onSurfaceVariant) : null,
        ),
        const SizedBox(width: AppConstants.p12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.employeeName, style: AppTextStyle.labelLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              Text(data.employeeRole, style: AppTextStyle.labelMedium.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
        _buildStatusBadge(data.status),
      ],
    );
  }

  Widget _buildDetailsBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Column(
        children: data.displayDetails.entries.map((entry) {
          final bool isLast = data.displayDetails.keys.last == entry.key;
          return Column(
            children: [
              _buildDetailRow(context, entry.key, entry.value),
              if (!isLast) const Divider(height: AppConstants.p16, color: AppColors.border),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final String lowerLabel = label.toLowerCase();
    final bool isViewable = lowerLabel == 'reason' ||
        lowerLabel == 'attachments' ||
        lowerLabel == 'comments' ||
        lowerLabel == 'remarks';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.labelMedium.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(width: 16),
        if (isViewable && value != "None" && value != "N/A")
          GestureDetector(
            onTap: () => _showContentDialog(context, label, value),
            child: Text(
              "View",
              style: AppTextStyle.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        else
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyle.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    final String normStatus = data.status.toLowerCase();
    final bool isProcessed = ['approved', 'rejected', 'cancelled'].contains(normStatus);

    // --- RAISED REQUESTS MODE ---
    if (data.category == ApprovalCategory.raised) {
      return Row(
        children: [
          if (data.type == ApprovalType.timesheet && !isProcessed) ...[
            Expanded(child: _buildBtn(label: 'Delete', icon: Icons.delete_outline, color: AppColors.error, onPressed: () {})),
            const SizedBox(width: 12),
            Expanded(child: _buildBtn(label: 'Edit', icon: Icons.edit_outlined, color: AppColors.primary, onPressed: () {})),
          ] else if (data.type == ApprovalType.compOff && !isProcessed) ...[
            const Spacer(), // Reserved for specific Comp-off raised actions
          ] else ...[
            const Spacer(),
          ],
          const SizedBox(width: 12),
          _buildCommentIconButton(context),
        ],
      );
    }

    // --- TEAM APPROVALS MODE ---
    bool showApprove = true;
    bool showReject = true;
    bool isApproveEnabled = false;
    bool isRejectEnabled = false;

    switch (data.type) {
      case ApprovalType.leave:
        isApproveEnabled = data.availableActions.contains('Approve');
        isRejectEnabled = data.availableActions.contains('Reject');
        break;
      case ApprovalType.attendance:
      case ApprovalType.compOff:
        isApproveEnabled = !isProcessed;
        isRejectEnabled = !isProcessed;
        break;
      case ApprovalType.timesheet:
        showReject = false; // Rule: Timesheet only shows Approve
        isApproveEnabled = !isProcessed;
        break;
    }

    return Row(
      children: [
        if (!isProcessed) ...[
          if (showReject)
            Expanded(child: _buildBtn(label: 'Reject', icon: Icons.cancel_outlined, color: AppColors.error, onPressed: isRejectEnabled ? () {} : null)),
          if (showReject && showApprove) const SizedBox(width: 12),
          if (showApprove)
            Expanded(child: _buildBtn(label: 'Approve', icon: Icons.check_circle_outline, color: AppColors.success, onPressed: isApproveEnabled ? () {} : null)),
          const SizedBox(width: 12),
        ],
        if (isProcessed || (!showApprove && !showReject)) const Spacer(),
        _buildCommentIconButton(context),
      ],
    );
  }

  Widget _buildCommentIconButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primaryFixed, borderRadius: BorderRadius.circular(AppConstants.r8)),
      child: IconButton(
        icon: const Icon(Icons.chat_bubble, color: AppColors.primary, size: 20),
        onPressed: () => _showAddCommentDialog(context),
      ),
    );
  }

  Widget _buildBtn({required String label, required IconData icon, required Color color, VoidCallback? onPressed}) {
    final bool isDisabled = onPressed == null;
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: isDisabled ? color.withValues(alpha: 0.3) : color),
      label: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: isDisabled ? color.withValues(alpha: 0.3) : color)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isDisabled ? color.withValues(alpha: 0.2) : color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  void _showContentDialog(BuildContext context, String title, String content) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        IconButton(icon: const Icon(Icons.cancel_outlined), onPressed: () => Navigator.pop(context))
      ]),
      content: Text(content),
    ));
  }

  void _showAddCommentDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Add Comment", style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text("This comment will be visible to the employee.", style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 16),
        TextField(maxLines: 3, decoration: InputDecoration(hintText: "Enter comment...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
      ]),
      actions: [
        Row(children: [
          Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.black)))),
          Expanded(child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF94B1F7), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text("Add Comment", style: TextStyle(color: Colors.white)),
          )),
        ])
      ],
    ));
  }

  Widget _buildStatusBadge(String status) {
    final String norm = status.toLowerCase();
    final bool isAppr = norm == 'approved';
    final bool isErr = norm == 'rejected' || norm == 'cancelled';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAppr ? AppColors.successBg : (isErr ? AppColors.errorContainer : AppColors.warningBg),
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
      child: Text(status.toUpperCase(), style: AppTextStyle.labelSmall.copyWith(color: isAppr ? AppColors.success : (isErr ? AppColors.error : AppColors.warning), fontWeight: FontWeight.bold)),
    );
  }
}