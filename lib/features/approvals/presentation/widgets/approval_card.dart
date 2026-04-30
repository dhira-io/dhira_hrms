import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/entities/approval_type.dart';
import '../../domain/usecases/add_comment_usecase.dart';

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
          _buildHeader(context),
          const SizedBox(height: AppConstants.p16),
          _buildDetailsBox(context),
          if (data.conflictingLeaves.isNotEmpty) ...[
            const SizedBox(height: AppConstants.p12),
            _ConflictingLeavesSection(conflictingLeaves: data.conflictingLeaves),
          ],
          const SizedBox(height: AppConstants.p16),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Hide user profile information for raised requests
    if (data.category == ApprovalCategory.raised) {
      return Align(
        alignment: Alignment.centerRight,
        child: _buildStatusBadge(context, data.status),
      );
    }
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
        _buildStatusBadge(context, data.status),
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
    final l10n = AppLocalizations.of(context)!;
    final String lowerLabel = label.toLowerCase();
    
    // Determine viewable state before translating the label
    final bool isViewable = lowerLabel == 'reason' ||
        lowerLabel == 'attachments' ||
        lowerLabel == 'comments' ||
        lowerLabel == 'remarks';

    String localizedLabel = label;
    switch (label) {
      case 'Leave Type': localizedLabel = l10n.leaveType; break;
      case 'From Date': localizedLabel = l10n.fromDate; break;
      case 'To Date': localizedLabel = l10n.toDate; break;
      case 'Days': localizedLabel = l10n.daysLabel; break;
      case 'Reason': localizedLabel = l10n.reason; break;
      case 'Date': localizedLabel = l10n.date; break;
      case 'In Time': localizedLabel = l10n.inTimeLabel; break;
      case 'Out Time': localizedLabel = l10n.outTimeLabel; break;
      case 'Attachments': localizedLabel = l10n.attachmentsLabel; break;
      case 'Week': localizedLabel = l10n.week; break;
      case 'Expected': localizedLabel = l10n.expectedLabel; break;
      case 'Actual': localizedLabel = l10n.actualLabel; break;
      case 'Projects': localizedLabel = l10n.projectsLabel; break;
      case 'Worked Date': localizedLabel = l10n.workedDateLabel; break;
      case 'Hours': localizedLabel = l10n.hoursLabel; break;
      case 'Req ID': localizedLabel = l10n.reqIdLabel; break;
      case 'Comments': localizedLabel = l10n.commentsLabel; break;
      case 'Week Range': localizedLabel = l10n.weekRangeLabel; break;
      case 'Total Hours': localizedLabel = l10n.totalHours(""); break;
      case 'Submitted Date': localizedLabel = l10n.submittedDateLabel; break;
      case 'Approver': localizedLabel = l10n.approver; break;
      case 'Remarks': localizedLabel = l10n.remarksLabel; break;
      case 'Comp-off Date': localizedLabel = l10n.compOffDateLabel; break;
    }

    // Clean up empty parameters if any
    localizedLabel = localizedLabel.replaceAll(":", "").trim();

    String localizedValue = value;
    if (value == "Unknown" || value == "N/A") {
      localizedValue = l10n.notAvailable;
    } else if (value == "None") {
      localizedValue = l10n.noneLabel;
    } else if (value.endsWith(" hrs")) {
      localizedValue = value.replaceAll(" hrs", " ${l10n.hoursLabel}");
    } else if (value.endsWith(" Day")) {
      localizedValue = value.replaceAll(" Day", " ${l10n.daysLabel}");
    } else if (value.endsWith(" Days")) {
      localizedValue = value.replaceAll(" Days", " ${l10n.daysLabel}");
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizedLabel, style: AppTextStyle.labelMedium.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(width: 16),
        if (isViewable && value != "None" && value != "N/A")
          GestureDetector(
            onTap: () => _showContentDialog(context, localizedLabel, localizedValue),
            child: Text(
              l10n.view,
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
              localizedValue,
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
      bool showEditWithdraw = false;
      if (data.type == ApprovalType.leave && data.fromDate != null) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final start = DateTime(data.fromDate!.year, data.fromDate!.month, data.fromDate!.day);
        // Upcoming = today or in the future
        showEditWithdraw = !start.isBefore(today) && !isProcessed;
      }

      final l10n = AppLocalizations.of(context)!;
      return Row(
        children: [
          if (data.type == ApprovalType.leave && showEditWithdraw) ...[
            Expanded(child: _buildBtn(label: l10n.edit, icon: Icons.edit_outlined, color: AppColors.primary, onPressed: () {})),
            const SizedBox(width: 12),
            Expanded(child: _buildBtn(label: l10n.withdraw, icon: Icons.undo, color: AppColors.error, onPressed: () {})),
          ] else if (data.type == ApprovalType.timesheet && !isProcessed) ...[
            Expanded(child: _buildBtn(label: l10n.delete, icon: Icons.delete_outline, color: AppColors.error, onPressed: () {})),
            const SizedBox(width: 12),
            Expanded(child: _buildBtn(label: l10n.edit, icon: Icons.edit_outlined, color: AppColors.primary, onPressed: () {})),
          ] else if (data.type == ApprovalType.compOff && !isProcessed) ...[
            const Spacer(), // Reserved for specific Comp-off raised actions
          ] else ...[
            const Spacer(),
          ],
          // Comment icon button removed for raised requests
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
        isApproveEnabled = !isProcessed && data.isMainApprover;
        break;
    }

    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        if (!isProcessed) ...[
          if (showReject)
            Expanded(child: _buildBtn(label: l10n.reject, icon: Icons.cancel_outlined, color: AppColors.error, onPressed: isRejectEnabled ? () {} : null)),
          if (showReject && showApprove) const SizedBox(width: 12),
          if (showApprove)
            Expanded(child: _buildBtn(label: l10n.approve, icon: Icons.check_circle_outline, color: AppColors.success, onPressed: isApproveEnabled ? () {} : null)),
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
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        IconButton(icon: const Icon(Icons.cancel_outlined), onPressed: () => Navigator.pop(context))
      ]),
      content: Text(content),
    ));
  }

  void _showAddCommentDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final TextEditingController commentController = TextEditingController();
    bool isLoading = false;

    showDialog(context: context, builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(l10n.addComment, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(l10n.commentVisibleToEmployee, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 16),
            TextField(
              controller: commentController,
              maxLines: 3, 
              decoration: InputDecoration(hintText: l10n.enterComment, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))
            ),
          ]),
          actions: [
            Row(children: [
              Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel, style: const TextStyle(color: AppColors.black)))),
              Expanded(child: ElevatedButton(
                onPressed: isLoading ? null : () async {
                  if (commentController.text.trim().isEmpty) return;
                  setState(() => isLoading = true);

                  try {
                    final useCase = Get.find<AddCommentUseCase>();
                    String doctype = 'Leave Application';
                    switch (data.type) {
                      case ApprovalType.leave: doctype = 'Leave Application'; break;
                      case ApprovalType.attendance: doctype = 'Attendance Regularization Request'; break;
                      case ApprovalType.timesheet: doctype = 'Employee Timesheet'; break;
                      case ApprovalType.compOff: doctype = 'Compensatory Leave Request'; break;
                    }

                    final result = await useCase(doctype, data.id, commentController.text.trim());
                    
                    if (context.mounted) {
                      setState(() => isLoading = false);
                      result.fold(
                        (failure) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message), backgroundColor: AppColors.error));
                        },
                        (_) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Comment added successfully'), backgroundColor: AppColors.success));
                        }
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      setState(() => isLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to add comment'), backgroundColor: AppColors.error));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2))
                    : Text(l10n.addComment, style: const TextStyle(color: AppColors.white)),
              )),
            ])
          ],
        );
      }
    ));
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    final String norm = status.toLowerCase();
    
    String localizedStatus = status;
    switch (norm) {
      case 'approved': localizedStatus = l10n.approved; break;
      case 'rejected': localizedStatus = l10n.rejected; break;
      case 'pending': localizedStatus = l10n.pending; break;
      case 'cancelled': localizedStatus = l10n.cancelledLabel; break;
      case 'draft': localizedStatus = l10n.draft; break;
    }

    final bool isAppr = norm == 'approved';
    final bool isErr = norm == 'rejected' || norm == 'cancelled';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAppr ? AppColors.successBg : (isErr ? AppColors.errorContainer : AppColors.warningBg),
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
      child: Text(localizedStatus.toUpperCase(), style: AppTextStyle.labelSmall.copyWith(color: isAppr ? AppColors.success : (isErr ? AppColors.error : AppColors.warning), fontWeight: FontWeight.bold)),
    );
  }
}

class _ConflictingLeavesSection extends StatefulWidget {
  final List<ConflictingLeaveEntity> conflictingLeaves;

  const _ConflictingLeavesSection({required this.conflictingLeaves});

  @override
  State<_ConflictingLeavesSection> createState() => _ConflictingLeavesSectionState();
}

class _ConflictingLeavesSectionState extends State<_ConflictingLeavesSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 20),
              const SizedBox(width: AppConstants.p8),
              Text(
                AppLocalizations.of(context)!.overlappingLeavesCount(widget.conflictingLeaves.length.toString()),
                style: AppTextStyle.labelMedium.copyWith(color: AppColors.warning, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(
                _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: AppColors.warning,
              ),
            ],
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: AppConstants.p12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.conflictingLeaves.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppConstants.p8),
            itemBuilder: (context, index) {
              final leaf = widget.conflictingLeaves[index];
              return Container(
                padding: const EdgeInsets.all(AppConstants.p8),
                decoration: BoxDecoration(
                  color: AppColors.warningBg.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                  border: Border.all(color: AppColors.warningBorder.withValues(alpha: 0.5)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.surfaceContainerHigh,
                      backgroundImage: leaf.profileImage != null ? NetworkImage(leaf.profileImage!) : null,
                      child: leaf.profileImage == null ? const Icon(Icons.person, size: 16, color: AppColors.onSurfaceVariant) : null,
                    ),
                    const SizedBox(width: AppConstants.p8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            leaf.employeeName,
                            style: AppTextStyle.labelSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.onSurface),
                          ),
                          Text(
                            leaf.leaveType,
                            style: AppTextStyle.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    _buildMiniStatusBadge(context, leaf.status),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildMiniStatusBadge(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    final String norm = status.toLowerCase();
    
    String localizedStatus = status;
    switch (norm) {
      case 'approved': localizedStatus = l10n.approved; break;
      case 'rejected': localizedStatus = l10n.rejected; break;
      case 'pending': localizedStatus = l10n.pending; break;
      case 'cancelled': localizedStatus = l10n.cancelledLabel; break;
      case 'draft': localizedStatus = l10n.draft; break;
    }

    final bool isAppr = norm == 'approved';
    final bool isErr = norm == 'rejected' || norm == 'cancelled';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isAppr ? AppColors.successBg : (isErr ? AppColors.errorContainer : AppColors.warningBg),
        borderRadius: BorderRadius.circular(AppConstants.r4),
      ),
      child: Text(
        localizedStatus,
        style: AppTextStyle.labelSmall.copyWith(
          fontSize: 9,
          color: isAppr ? AppColors.success : (isErr ? AppColors.error : AppColors.warning),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
