import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/entities/approval_type.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../leave/presentation/screens/apply_leave_screen.dart';
import '../../../leave/domain/entities/leave_entity.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import 'comments_dialog.dart';
import 'edit_timesheet_dialog.dart';
import '../../../../core/utils/date_time_utils.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
          child: data.profileImage == null ? Image.asset(AppAssets.defaultProfile) : null,
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
      case 'Day Segment': localizedLabel = l10n.daySegment; break;
    }

    // Clean up empty parameters if any
    localizedLabel = localizedLabel.replaceAll(":", "").trim();

    String localizedValue = value;
    if (value == "Unknown" || value == "N/A") {
      localizedValue = l10n.notAvailable;
    } else if (value == "None") {
      localizedValue = l10n.noneLabel;
    } else if (lowerLabel.contains('hours') || lowerLabel == 'expected' || lowerLabel == 'actual') {
      localizedValue = "$value ${l10n.hoursLabel}";
    } else if (lowerLabel == 'days') {
      localizedValue = "$value ${l10n.daysLabel}";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizedLabel, style: AppTextStyle.labelMedium.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(width: 16),
        if (isViewable && value != "None" && value != "N/A")
          GestureDetector(
            onTap: () {
              if (label == 'Comments') {
                _onViewComments(context);
              } else if (label == 'Attachments') {
                _onOpenAttachment(context);
              } else {
                _showContentDialog(context, localizedLabel, localizedValue);
              }
            },
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
            Expanded(child: _buildBtn(label: l10n.edit, icon: Icons.edit_outlined, color: AppColors.primary, onPressed: () => _onEditLeave(context))),
            const SizedBox(width: 12),
            Expanded(child: _buildBtn(label: l10n.withdraw, icon: Icons.undo, color: AppColors.error, onPressed: () => _onWithdrawLeave(context))),
          ] else if (data.type == ApprovalType.timesheet && !isProcessed) ...[
            Expanded(child: _buildBtn(label: l10n.delete, icon: Icons.delete_outline, color: AppColors.error, onPressed: () => _onDeleteTimesheet(context))),
            const SizedBox(width: 12),
            Expanded(child: _buildBtn(label: l10n.edit, icon: Icons.edit_outlined, color: AppColors.primary, onPressed: () => _onEditTimesheet(context))),
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
            Expanded(child: _buildBtn(
              label: l10n.reject, 
              icon: Icons.cancel_outlined, 
              color: AppColors.error, 
              onPressed: isRejectEnabled ? () => _showActionConfirmation(context, 'Reject') : null
            )),
          if (showReject && showApprove) const SizedBox(width: 12),
          if (showApprove)
            Expanded(child: _buildBtn(
              label: l10n.approve, 
              icon: Icons.check_circle_outline, 
              color: AppColors.success, 
              onPressed: isApproveEnabled ? () => _showActionConfirmation(context, 'Approve') : null
            )),
          const SizedBox(width: 12),
        ],
        if (isProcessed) const Spacer(),
        _buildCommentIconButton(context),
      ],
    );
  }

  void _onWithdrawLeave(BuildContext context) {
    _showActionConfirmation(context, 'Cancel');
  }

  Future<void> _onEditLeave(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    
    // 1. Show loading indicator while fetching employee details
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final localStorage = Get.find<LocalStorageService>();
      final userId = localStorage.getUserEmail() ?? "";
      
      final authDataSource = Get.find<AuthRemoteDataSource>();
      final employee = await authDataSource.getEmployeeDetails(userId);
      
      if (context.mounted) {
        Navigator.pop(context); // Remove loading indicator
        
        final leaveType = data.displayDetails['Leave Type'] ?? "";
        final reason = data.displayDetails['Reason'] ?? "";
        final daysText = data.displayDetails['Days'] ?? "0";
        final double days = double.tryParse(daysText.split(' ').first) ?? 0.0;

        String? segment = data.halfDaySegment;
        if (segment != null && segment.isNotEmpty) {
          final s = segment.toLowerCase();
          if (s.contains("first") || s.contains("morning") || s.contains("1st")) {
            segment = l10n.firstHalf;
          } else if (s.contains("second") || s.contains("afternoon") || s.contains("2nd")) {
            segment = l10n.secondHalf;
          }
        }

        final leave = LeaveEntity(
          name: data.id,
          employee: employee.empId, // Frappe name (ID)
          employeeName: employee.employeeName ?? "Unknown",
          leaveType: leaveType,
          fromDate: data.fromDate?.format() ?? "",
          toDate: data.toDate?.format() ?? "",
          status: data.status,
          description: reason,
          totalLeaveDays: days,
          halfDay: (data.isHalfDay || days == 0.5) ? 1 : 0,
          halfDayDate: (data.isHalfDay || days == 0.5) ? data.fromDate?.format() : null,
          halfDaySegment: segment,
        );

        final bool? success = await showDialog<bool>(
          context: context,
          builder: (context) => Dialog.fullscreen(
            child: ApplyLeaveScreen(
              employeeId: employee.empId,
              leave: leave,
            ),
          ),
        );

        if (context.mounted && success == true) {
          context.read<ApprovalsBloc>().add(
                ApprovalsEvent.categoryChanged(data.type, data.category),
              );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Remove loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.somethingWentWrong)),
        );
      }
    }
  }

  void _showActionConfirmation(BuildContext context, String action) {
    final approvalsBloc = BlocProvider.of<ApprovalsBloc>(context);
    final l10n = AppLocalizations.of(context)!;
    
    String title = l10n.reject;
    if (action == 'Approve') title = l10n.approve;
    if (action == 'Cancel') title = l10n.withdraw;

    String content = l10n.rejectConfirmGeneric;
    if (data.type == ApprovalType.leave) {
      if (action == 'Approve') {
        content = l10n.approveConfirmation;
      } else if (action == 'Cancel') {
        content = l10n.withdrawConfirmation;
      } else {
        content = l10n.rejectConfirmation;
      }
    } else {
      if (action == 'Approve') {
        content = l10n.approveConfirmGeneric;
      } else if (action == 'Cancel') {
        content = l10n.withdrawConfirmation;
      } else {
        content = l10n.rejectConfirmGeneric;
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r16)),
        title: Text(title, style: AppTextStyle.headlineSmall.copyWith(fontWeight: FontWeight.bold)),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.no, style: const TextStyle(color: AppColors.black)),
          ),
          ElevatedButton(
            onPressed: () {
              approvalsBloc.add(
                ApprovalsEvent.workflowActionSubmitted(
                  requestId: data.id,
                  action: action,
                  type: data.type,
                  category: data.category,
                ),
              );
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: action == 'Approve' ? AppColors.success : AppColors.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size(0, 40),
            ),
            child: Text(
              l10n.yes,
              style: AppTextStyle.labelLarge.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p12),
      ),
    );
  }

  void _showContentDialog(BuildContext context, String title, String content) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: AppTextStyle.headlineSmall.copyWith(fontWeight: FontWeight.bold)),
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
                    final String doctype = data.type.doctype;

                    final result = await useCase(doctype, data.id, commentController.text.trim());
                    
                    if (context.mounted) {
                      setState(() => isLoading = false);
                      result.fold(
                        (failure) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message), backgroundColor: AppColors.error));
                        },
                        (_) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.commentAddedSuccessfully), backgroundColor: AppColors.success));
                        }
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      setState(() => isLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.failedToAddComment), backgroundColor: AppColors.error));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: isLoading 
                    ? const SizedBox(width: AppConstants.p20, height: AppConstants.p20, child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2))
                    : Text(l10n.addComment, style: AppTextStyle.labelLarge.copyWith(color: AppColors.white)),
              )),
            ])
          ],
        );
      }
    ));
  }

  Future<void> _onOpenAttachment(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final url = data.fileUrl;
    if (url == null || url.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.noAttachmentFound)),
        );
      }
      return;
    }

    final String lowerUrl = url.toLowerCase();
    final bool isPdf   = lowerUrl.endsWith('.pdf');
    final bool isImage = lowerUrl.endsWith('.png') ||
                         lowerUrl.endsWith('.jpg') ||
                         lowerUrl.endsWith('.jpeg') ||
                         lowerUrl.endsWith('.gif') ||
                         lowerUrl.endsWith('.webp');
    final bool isOffice = lowerUrl.endsWith('.xlsx') ||
                          lowerUrl.endsWith('.xls')  ||
                          lowerUrl.endsWith('.docx') ||
                          lowerUrl.endsWith('.doc')  ||
                          lowerUrl.endsWith('.pptx') ||
                          lowerUrl.endsWith('.ppt');

    // Title for the dialog
    String dialogTitle;
    if (isPdf)         dialogTitle = l10n.pdfViewer;
    else if (isImage)  dialogTitle = l10n.imageViewer;
    else if (isOffice) dialogTitle = l10n.documentViewer;
    else               dialogTitle = l10n.attachmentsLabel;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.p8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        dialogTitle,
                        style: AppTextStyle.labelLarge.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: _buildAttachmentPreview(url, isPdf, isImage, isOffice, l10n),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.platformDefault);
                      }
                    },
                    child: Text(l10n.openInBrowser),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentPreview(String url, bool isPdf, bool isImage, bool isOffice, AppLocalizations l10n) {
    if (isPdf) {
      return SfPdfViewer.network(url);
    } else if (isImage) {
      return InteractiveViewer(
        child: Image.network(
          url,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                const SizedBox(height: 8),
                Text(l10n.somethingWentWrong),
              ],
            ),
          ),
        ),
      );
    } else if (isOffice) {
      // Use Google Docs Viewer to render Office documents in-app
      final String viewerUrl =
          'https://docs.google.com/gview?embedded=true&url=${Uri.encodeComponent(url)}';
      return _OfficeDocViewer(viewerUrl: viewerUrl, loadingText: l10n.loadingDocument);
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.insert_drive_file, size: 64, color: AppColors.onSurfaceVariant),
              const SizedBox(height: 16),
              Text(l10n.unsupportedPreviewType, style: AppTextStyle.bodyMedium),
              const SizedBox(height: 8),
              Text(l10n.useBrowserToViewFile, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }
  }

  void _onViewComments(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    context.read<ApprovalsBloc>().add(
          ApprovalsEvent.commentsRequested(
            requestId: data.id,
            doctype: data.type.doctype,
          ),
        );

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<ApprovalsBloc>(),
        child: CommentsDialog(
          title: l10n.commentsLabel,
          subtitle: "${data.type.doctype} - ${data.id}",
        ),
      ),
    );
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
  void _onEditTimesheet(BuildContext context) {
    context.read<ApprovalsBloc>().add(ApprovalsEvent.editTimesheetRequested(requestId: data.id));
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: context.read<ApprovalsBloc>(),
        child: const EditTimesheetDialog(),
      ),
    );
  }

  void _onDeleteTimesheet(BuildContext context) {
    final approvalsBloc = context.read<ApprovalsBloc>();
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(l10n.deleteTimesheet, style: AppTextStyle.h3.copyWith(fontSize: 20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: AppTextStyle.bodyMedium,
                children: [
                  TextSpan(text: "${l10n.areYouSureDelete} "),
                  TextSpan(text: data.id, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSecondaryFixedVariant)),
                  const TextSpan(text: "?"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.deleteTimesheetWarning,
              style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(l10n.cancel, style: const TextStyle(color: AppColors.black)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    approvalsBloc.add(ApprovalsEvent.deleteTimesheetRequested(requestId: data.id));
                    Navigator.pop(dialogContext);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(l10n.deleteTimesheet, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
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
          Column(
            children: widget.conflictingLeaves.map((leaf) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.p8),
                child: Container(
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
                        child: leaf.profileImage == null ? Image.asset(AppAssets.defaultProfile) : null,
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
                ),
              );
            }).toList(),
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

/// A StatefulWidget that renders Office documents (XLSX, DOCX, PPTX) via
/// Google Docs Viewer inside an InAppWebView.
class _OfficeDocViewer extends StatefulWidget {
  final String viewerUrl;
  final String loadingText;

  const _OfficeDocViewer({required this.viewerUrl, required this.loadingText});

  @override
  State<_OfficeDocViewer> createState() => _OfficeDocViewerState();
}

class _OfficeDocViewerState extends State<_OfficeDocViewer> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(widget.viewerUrl),
          ),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            useWideViewPort: true,
            loadWithOverviewMode: true,
            builtInZoomControls: true,
            displayZoomControls: false,
            domStorageEnabled: true,
          ),
          onLoadStart: (controller, url) {
            if (mounted) setState(() { _isLoading = true; _hasError = false; });
          },
          onLoadStop: (controller, url) {
            if (mounted) setState(() => _isLoading = false);
          },
          onReceivedError: (controller, request, error) {
            if (mounted) setState(() { _isLoading = false; _hasError = true; });
          },
        ),
        if (_isLoading)
          Container(
            color: AppColors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(widget.loadingText, style: AppTextStyle.bodyMedium),
                ],
              ),
            ),
          ),
        if (_hasError && !_isLoading)
          Container(
            color: AppColors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'Failed to load document.\nTry "Open in Browser".',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
