import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/approval_request_entity.dart';

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
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER: Avatar, Name, Role, and Status Badge
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.surfaceContainerHigh,
                backgroundImage: data.profileImage != null
                    ? NetworkImage(data.profileImage!)
                    : null,
                child: data.profileImage == null
                    ? const Icon(Icons.person, color: AppColors.onSurfaceVariant)
                    : null,
              ),
              const SizedBox(width: AppConstants.p12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.employeeName,
                      style: AppTextStyle.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      data.employeeRole,
                      style: AppTextStyle.labelMedium.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(data.status),
            ],
          ),
          const SizedBox(height: AppConstants.p16),

          // DYNAMIC DETAILS BOX: Loop through the mapped fields
          Container(
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
                    _buildDetailRow(entry.key, entry.value),
                    if (!isLast)
                      const Divider(height: AppConstants.p16, color: AppColors.border),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppConstants.p16),

          // ACTIONS: Conditional rendering based on status
          _buildActions(),
        ],
      ),
    );
  }

  /// Builds the detail rows inside the grey box with proper text wrapping
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.labelMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyle.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the top-right status badge with dynamic colors
  Widget _buildStatusBadge(String status) {
    final String normalizedStatus = status.toLowerCase();
    Color bgColor = AppColors.warningBg;
    Color textColor = AppColors.warning;

    if (normalizedStatus == 'approved') {
      bgColor = AppColors.successBg;
      textColor = AppColors.success;
    } else if (normalizedStatus == 'rejected' || normalizedStatus == 'cancelled') {
      bgColor = AppColors.errorContainer;
      textColor = AppColors.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p8, vertical: AppConstants.p4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTextStyle.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Logic: Hide buttons if Approved/Rejected, show only comment icon
  Widget _buildActions() {
    final String normalizedStatus = data.status.toLowerCase();
    final bool isProcessed = normalizedStatus == 'approved' ||
        normalizedStatus == 'rejected' ||
        normalizedStatus == 'cancelled';

    return Row(
      children: [
        if (!isProcessed) ...[
          Expanded(
            child: _buildActionButton(
              label: 'Reject',
              color: AppColors.error,
              onPressed: () {
                // TODO: Implement Reject Logic
              },
            ),
          ),
          const SizedBox(width: AppConstants.p12),
          Expanded(
            child: _buildActionButton(
              label: 'Approve',
              color: AppColors.success,
              onPressed: () {
                // TODO: Implement Approve Logic
              },
            ),
          ),
          const SizedBox(width: AppConstants.p12),
        ],

        // If processed, push the comment icon to the right
        if (isProcessed) const Spacer(),

        // Always show the comment icon
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryFixed,
            borderRadius: BorderRadius.circular(AppConstants.r8),
          ),
          child: IconButton(
            icon: const Icon(Icons.chat_bubble, color: AppColors.primary, size: 20),
            onPressed: () {
              // TODO: Implement Comments Logic
            },
          ),
        ),
      ],
    );
  }

  /// Helper for Outlined Action Buttons
  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.r8),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p12),
      ),
      child: Text(
        label,
        style: AppTextStyle.labelLarge.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}