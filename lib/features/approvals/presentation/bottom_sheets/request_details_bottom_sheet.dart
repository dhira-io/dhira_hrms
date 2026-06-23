import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:dhira_hrms/features/approvals/data/constants/approvals_api_constants.dart';
import 'package:dhira_hrms/core/utils/string_utils.dart';
import 'package:dhira_hrms/features/approvals/presentation/widgets/approval_card/mini_status_badge.dart';
import 'package:dhira_hrms/features/approvals/presentation/dialogs/action_confirmation_dialog.dart';
import 'package:dhira_hrms/features/approvals/presentation/dialogs/delete_timesheet_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestDetailsBottomSheet extends StatefulWidget {
  final ApprovalRequestEntity data;

  const RequestDetailsBottomSheet({super.key, required this.data});

  @override
  State<RequestDetailsBottomSheet> createState() => _RequestDetailsBottomSheetState();
}

class _RequestDetailsBottomSheetState extends State<RequestDetailsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data.type == ApprovalType.timesheet) {
      context.read<ApprovalsBloc>().add(
        ApprovalsEvent.editTimesheetRequested(requestId: widget.data.id),
      );
      if (widget.data.category == ApprovalCategory.raised) {
        context.read<ApprovalsBloc>().add(
          ApprovalsEvent.commentsRequested(
            requestId: widget.data.id,
            doctype: ApprovalsApiConstants.doctypeEmployeeTimesheet,
          ),
        );
      }
    } else if (widget.data.type == ApprovalType.compOff) {
      if (widget.data.category == ApprovalCategory.raised) {
        context.read<ApprovalsBloc>().add(
          ApprovalsEvent.commentsRequested(
            requestId: widget.data.id,
            doctype: ApprovalsApiConstants.doctypeCompensatoryLeave,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onAction(BuildContext context, String action) {
    if (_commentController.text.trim().isNotEmpty) {
      context.read<ApprovalsBloc>().add(
            ApprovalsEvent.commentSubmitted(
              requestId: widget.data.id,
              type: widget.data.type,
              comment: _commentController.text.trim(),
            ),
          );
    }
    
    context.read<ApprovalsBloc>().add(
          ApprovalsEvent.workflowActionSubmitted(
            requestId: widget.data.id,
            action: action,
            type: widget.data.type,
            category: widget.data.category,
          ),
        );
    Navigator.pop(context);
  }

  Widget _buildCommentsSection(BuildContext context, AppLocalizations l10n) {
    if (!(widget.data.type == ApprovalType.timesheet || widget.data.type == ApprovalType.compOff) || widget.data.category != ApprovalCategory.raised) {
      return const SizedBox.shrink();
    }
    
    return BlocBuilder<ApprovalsBloc, ApprovalsState>(
      builder: (context, state) {
        if (state is Success) {
          if (state.data.isCommentsLoading) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoading(width: 120.w, height: 16.h),
                  const SizedBox(height: AppConstants.p12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppConstants.p12),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).surface,
                      border: Border.all(color: AppColors.of(context).outlineVariant),
                      borderRadius: BorderRadius.circular(AppConstants.r8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerLoading(width: 150.w, height: 14.h),
                        SizedBox(height: 8.h),
                        ShimmerLoading(width: double.infinity, height: 14.h),
                        SizedBox(height: 4.h),
                        ShimmerLoading(width: 200.w, height: 14.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          
          final comments = state.data.comments;
          if (comments.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppConstants.p16),
              Text(
                l10n.commentsLabel,
                style: AppTextStyle.titleSmall.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppConstants.p8),
              ...comments.map((c) => Container(
                margin: const EdgeInsets.only(bottom: AppConstants.p8),
                padding: const EdgeInsets.all(AppConstants.p12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.of(context).surface,
                  border: Border.all(color: AppColors.of(context).outlineVariant),
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            c.commentBy ?? c.owner,
                            style: AppTextStyle.labelMedium.copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${DateTimeUtils.formatToDMYShort(c.creation)}',
                          style: AppTextStyle.labelSmall.copyWith(color: AppColors.of(context).onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.p4),
                    Text(
                      c.content.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
                      style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).onSurface),
                    ),
                  ],
                ),
              )),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDetailRow(MapEntry<String, String> entry, BuildContext context) {
    bool isAttachment = entry.key.toLowerCase().contains('attachment');
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.key,
            style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).onSurfaceVariant),
          ),
          const SizedBox(width: AppConstants.p24),
          Flexible(
            child: Text(
              entry.value,
              textAlign: TextAlign.right,
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: isAttachment ? AppColors.of(context).primary : AppColors.of(context).onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String initials = widget.data.employeeName.getInitials.isNotEmpty
        ? widget.data.employeeName.getInitials
        : 'U';
        
    final baseUrl = ApiConstants.baseUrl.replaceAll(RegExp(r'/$'), '');
    final bool hasValidImage = widget.data.profileImage != null && 
                               widget.data.profileImage!.isNotEmpty && 
                               widget.data.profileImage != baseUrl;
    
    final l10n = AppLocalizations.of(context)!;
    
    // Separate Reason from other details
    final Map<String, String> details = Map.from(widget.data.displayDetails);
    String? reason;
    
    final reasonKey = details.keys.firstWhere(
      (k) {
        final lower = k.toLowerCase();
        if (lower == RequestDetailKeys.justification || lower == RequestDetailKeys.remarks) return true;
        if (lower == RequestDetailKeys.reason && widget.data.type != ApprovalType.attendance) return true;
        return false;
      },
      orElse: () => '',
    );
    
    if (reasonKey.isNotEmpty) {
      reason = details.remove(reasonKey);
    }

    final attachmentKeys = details.keys.where((k) => k.toLowerCase().contains(RequestDetailKeys.attachment)).toList();
    for (var k in attachmentKeys) {
      details.remove(k);
    }
    details.remove(RequestDetailKeys.submittedDate);

    final String normStatus = widget.data.status.toLowerCase();
    final bool isProcessed = [
      ApprovalStatus.approved.toLowerCase(),
      ApprovalStatus.rejected.toLowerCase(),
      ApprovalStatus.cancelled.toLowerCase(),
    ].contains(normStatus);

    bool showEditDelete = false;
    if (widget.data.type == ApprovalType.leave) {
      bool isFuture = true;
      if (widget.data.fromDate != null) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final leaveDate = DateTime(widget.data.fromDate!.year, widget.data.fromDate!.month, widget.data.fromDate!.day);
        isFuture = !leaveDate.isBefore(today);
      }
      showEditDelete = !isProcessed && isFuture;
    } else if (widget.data.type == ApprovalType.timesheet) {
      showEditDelete = !isProcessed;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.r24)),
      ),
      padding: EdgeInsets.only(
        left: AppConstants.p24,
        right: AppConstants.p24,
        top: AppConstants.p24,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppConstants.p24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.requestDetails,
                style: AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              )
            ],
          ),
          const SizedBox(height: AppConstants.p16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.data.category == ApprovalCategory.team)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: AppConstants.p48,
                          height: AppConstants.p48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.of(context).primary,
                          ),
                          child: ClipOval(
                            child: hasValidImage
                                ? Image.network(
                                    widget.data.profileImage!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: AppColors.of(context).primary,
                                        child: Center(
                                          child: Text(
                                            initials,
                                            style: AppTextStyle.titleMedium.copyWith(
                                              color: AppColors.of(context).onPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                      initials,
                                      style: AppTextStyle.titleMedium.copyWith(
                                        color: AppColors.of(context).onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.p12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.employeeName,
                                style: AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
                              ),
                              if (widget.data.employeeRole.isNotEmpty)
                                Text(
                                  widget.data.employeeRole,
                                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).onSurfaceVariant),
                                ),
                              if (widget.data.displayDetails[RequestDetailKeys.submittedDate] != null)
                                Text(
                                  l10n.submittedOn(widget.data.displayDetails[RequestDetailKeys.submittedDate]!),
                                  style: AppTextStyle.bodySmall.copyWith(
                                    color: AppColors.of(context).onSurfaceVariant,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        MiniStatusBadge(status: widget.data.status),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MiniStatusBadge(status: widget.data.status),
                        const SizedBox(width: AppConstants.p12),
                        if (widget.data.displayDetails[RequestDetailKeys.submittedDate] != null)
                          Expanded(
                            child: Text(
                              l10n.submittedOn(widget.data.displayDetails[RequestDetailKeys.submittedDate]!),
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.of(context).onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: AppConstants.p24),
                  Container(
                    padding: const EdgeInsets.all(AppConstants.p16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.of(context).outline),
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (widget.data.type == ApprovalType.leave && widget.data.category == ApprovalCategory.raised)
                              ? (details[RequestDetailKeys.leaveType] ?? l10n.leaveApplication)
                              : (widget.data.type == ApprovalType.leave 
                                  ? l10n.leaveApplication 
                                  : (widget.data.type == ApprovalType.timesheet 
                                      ? l10n.timesheet 
                                      : (widget.data.type == ApprovalType.compOff 
                                          ? l10n.comOff 
                                          : l10n.attendanceRegularization))),
                          style: AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppConstants.p16),
                        if (widget.data.type == ApprovalType.timesheet)
                          BlocBuilder<ApprovalsBloc, ApprovalsState>(
                            builder: (context, state) {
                              if (state is Success && state.data.isTimesheetLoading) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: AppConstants.p8),
                                  child: Column(
                                    children: List.generate(3, (index) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ShimmerLoading(width: 100.w, height: 16.h),
                                          ShimmerLoading(width: 80.w, height: 16.h),
                                        ],
                                      ),
                                    )),
                                  ),
                                );
                              }
                              
                              Map<String, String> updatedDetails = Map.from(details);
                              if (state is Success && state.data.editingTimesheet != null) {
                                final ts = state.data.editingTimesheet!;
                                updatedDetails.remove(RequestDetailKeys.totalHours);
                                updatedDetails.remove(RequestDetailKeys.projects);
                                updatedDetails[RequestDetailKeys.expectedHours] = '${ts.expectedHoursTotal} ${l10n.hoursLabel}';
                                updatedDetails[RequestDetailKeys.actualHours] = '${ts.totalSpentHours} ${l10n.hoursLabel}';
                                
                                final projectsSet = ts.projectAssignments
                                    ?.map((a) => a.project ?? '')
                                    .where((p) => p.isNotEmpty)
                                    .toSet() ?? {};
                                updatedDetails[RequestDetailKeys.projects] = projectsSet.isNotEmpty ? projectsSet.join(', ') : l10n.notAvailable;
                              }

                              return Column(
                                children: updatedDetails.entries.map((entry) => _buildDetailRow(entry, context)).toList(),
                              );
                            },
                          )
                        else
                          ...details.entries.map((entry) => _buildDetailRow(entry, context)),
                      ],
                    ),
                  ),
                  if (reason != null && reason.isNotEmpty && reason != AppConstants.noneValue && reason != AppConstants.naValue) ...[
                    const SizedBox(height: AppConstants.p16),
                    Text(
                      l10n.reasonJustification,
                      style: AppTextStyle.titleSmall.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppConstants.p8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppConstants.p16),
                      decoration: BoxDecoration(
                        color: AppColors.of(context).surface,
                        border: Border.all(color: AppColors.of(context).outlineVariant),
                        borderRadius: BorderRadius.circular(AppConstants.r8),
                      ),
                      child: Text(
                        reason,
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppColors.of(context).onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],

                  if (widget.data.category == ApprovalCategory.team && !isProcessed) ...[
                    const SizedBox(height: AppConstants.p24),
                    Text(
                      l10n.addComment,
                      style: AppTextStyle.titleSmall.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppConstants.p8),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: l10n.enterYourComment,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.r8),
                          borderSide: BorderSide(color: AppColors.of(context).outline),
                        ),
                        contentPadding: const EdgeInsets.all(AppConstants.p12),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: AppConstants.p24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => ActionConfirmationDialog(
                                  action: ApprovalActions.reject,
                                  data: widget.data,
                                  onConfirm: () {
                                    _onAction(context, ApprovalActions.reject);
                                  },
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.of(context).error.withValues(alpha: 0.1),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(color: AppColors.of(context).error.withValues(alpha: 0.5)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cancel_outlined, color: AppColors.of(context).error, size: 20),
                                const SizedBox(width: 8),
                                Text(l10n.reject, style: AppTextStyle.labelLarge.copyWith(color: AppColors.of(context).error)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.p16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _onAction(context, ApprovalActions.approve),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.of(context).success.withValues(alpha: 0.1),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(color: AppColors.of(context).success.withValues(alpha: 0.5)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_outline, color: AppColors.of(context).success, size: 20),
                                const SizedBox(width: 8),
                                Text(l10n.approve, style: AppTextStyle.labelLarge.copyWith(color: AppColors.of(context).success)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  _buildCommentsSection(context, l10n),
                  if (widget.data.category == ApprovalCategory.raised) ...[
                    if (widget.data.status.toLowerCase() == ApprovalStatus.rejected.toLowerCase() && widget.data.managerReview != null && widget.data.managerReview!.isNotEmpty) ...[
                      const SizedBox(height: AppConstants.p16),
                      Text(
                        l10n.rejectionReason,
                        style: AppTextStyle.titleSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.of(context).error),
                      ),
                      const SizedBox(height: AppConstants.p8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppConstants.p16),
                        decoration: BoxDecoration(
                          color: AppColors.of(context).error.withValues(alpha: 0.1),
                          border: Border.all(color: AppColors.of(context).error.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(AppConstants.r8),
                        ),
                        child: Text(
                          widget.data.managerReview!,
                          style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).error),
                        ),
                      ),
                    ] else if (widget.data.status.toLowerCase() != ApprovalStatus.rejected.toLowerCase()) ...[
                      const SizedBox(height: AppConstants.p16),
                      Text(
                        l10n.managerReview,
                        style: AppTextStyle.titleSmall.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppConstants.p8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppConstants.p16),
                        decoration: BoxDecoration(
                          color: AppColors.of(context).surface,
                          border: Border.all(color: AppColors.of(context).outlineVariant),
                          borderRadius: BorderRadius.circular(AppConstants.r8),
                        ),
                        child: Text(
                          (widget.data.managerReview != null && widget.data.managerReview!.isNotEmpty) 
                              ? widget.data.managerReview! 
                              : l10n.managerReviewFallback,
                          style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).onSurfaceVariant),
                        ),
                      ),
                    ],
                    if (widget.data.fileUrl != null && widget.data.fileUrl!.isNotEmpty && widget.data.fileUrl != AppConstants.noneValue) ...[
                      const SizedBox(height: AppConstants.p16),
                      Text(
                        l10n.attachment,
                        style: AppTextStyle.titleSmall.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: AppConstants.p8),
                      InkWell(
                        onTap: () async {
                          final baseUrl = ApiConstants.baseUrl.replaceAll(RegExp(r'/$'), '');
                          final fileUrl = widget.data.fileUrl!;
                          final fullUrl = fileUrl.startsWith('http') ? fileUrl : '$baseUrl$fileUrl';
                          final uri = Uri.parse(fullUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                        borderRadius: BorderRadius.circular(AppConstants.r8),
                        child: Container(
                          padding: const EdgeInsets.all(AppConstants.p12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.of(context).primary),
                            borderRadius: BorderRadius.circular(AppConstants.r8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.attach_file, color: AppColors.of(context).primary, size: 20),
                              const SizedBox(width: AppConstants.p8),
                              Expanded(
                                child: Text(
                                  widget.data.fileUrl!.split('/').last,
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    color: AppColors.of(context).primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (showEditDelete) ...[
                      const SizedBox(height: AppConstants.p24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                side: BorderSide(color: AppColors.of(context).outline),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                              ),
                              child: Text(l10n.editRequest, style: AppTextStyle.labelLarge.copyWith(color: AppColors.of(context).onSurface)),
                            ),
                          ),
                          const SizedBox(width: AppConstants.p16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (widget.data.type == ApprovalType.timesheet) {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => DeleteTimesheetDialog(
                                      requestId: widget.data.id,
                                      onDelete: () {
                                        context.read<ApprovalsBloc>().add(
                                          ApprovalsEvent.deleteTimesheetRequested(requestId: widget.data.id),
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => ActionConfirmationDialog(
                                      action: ApprovalActions.cancel,
                                      data: widget.data,
                                      onConfirm: () {
                                        _onAction(context, ApprovalActions.cancel);
                                      },
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.of(context).error,
                                foregroundColor: AppColors.of(context).onPrimary,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                              ),
                              child: Text(
                                widget.data.type == ApprovalType.timesheet ? l10n.delete : l10n.withdraw, 
                                style: AppTextStyle.labelLarge.copyWith(color: AppColors.of(context).onPrimary)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
