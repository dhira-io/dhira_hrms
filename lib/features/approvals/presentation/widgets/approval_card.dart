import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/screens/leave_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../../../leave/domain/entities/leave_entity.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import '../bottom_sheets/edit_timesheet_bottom_sheet.dart';

// Extracted Widgets
import 'approval_card/approval_card_header.dart';
import 'approval_card/approval_card_details.dart';
import 'approval_card/approval_card_actions.dart';
import 'approval_card/conflicting_leaves_section.dart';

// Extracted Dialogs
import '../dialogs/action_confirmation_dialog.dart';
import '../dialogs/add_comment_dialog.dart';
import '../dialogs/attachment_dialog.dart';
import '../dialogs/delete_timesheet_dialog.dart';
import '../dialogs/content_display_dialog.dart';
import 'comments_dialog.dart';

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
          ApprovalCardHeader(data: data),
          const SizedBox(height: AppConstants.p16),
          ApprovalCardDetails(
            data: data,
            onViewComments: () => _onViewComments(context),
            onOpenAttachment: () => _onOpenAttachment(context),
            onShowContent: (title, content) => _showContentDialog(context, title, content),
          ),
          if (data.conflictingLeaves.isNotEmpty) ...[
            const SizedBox(height: AppConstants.p12),
            ConflictingLeavesSection(conflictingLeaves: data.conflictingLeaves),
          ],
          const SizedBox(height: AppConstants.p16),
          ApprovalCardActions(
            data: data,
            onEditLeave: () => _onEditLeave(context),
            onWithdrawLeave: () => _onWithdrawLeave(context),
            onDeleteTimesheet: () => _onDeleteTimesheet(context),
            onEditTimesheet: () => _onEditTimesheet(context),
            onAction: (action) => _showActionConfirmation(context, action),
            onAddComment: () => _showAddCommentDialog(context),
          ),
        ],
      ),
    );
  }

  void _onWithdrawLeave(BuildContext context) {
    _showActionConfirmation(context, ApprovalActions.cancel);
  }

  Future<void> _onEditLeave(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

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
          employee: employee.empId,
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
          fileUrl: data.fileUrl,
        );

        final bool? success = await showDialog<bool>(
          context: context,
          builder: (context) => Dialog.fullscreen(
            child: LeaveEditScreen(
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
        Navigator.pop(context);
        ToastUtils.showError(l10n.somethingWentWrong);
      }
    }
  }

  void _showActionConfirmation(BuildContext context, String action) {
    final approvalsBloc = context.read<ApprovalsBloc>();
    showDialog(
      context: context,
      builder: (context) => ActionConfirmationDialog(
        action: action,
        data: data,
        onConfirm: () {
          approvalsBloc.add(
            ApprovalsEvent.workflowActionSubmitted(
              requestId: data.id,
              action: action,
              type: data.type,
              category: data.category,
            ),
          );
        },
      ),
    );
  }

  void _showContentDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => ContentDisplayDialog(title: title, content: content),
    );
  }

  void _showAddCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddCommentDialog(data: data),
    );
  }

  void _onOpenAttachment(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final url = data.fileUrl;
    if (url == null || url.isEmpty) {
      ToastUtils.showInfo(l10n.noAttachmentFound);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AttachmentDialog(url: url),
    );
  }

  void _onViewComments(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final approvalsBloc = context.read<ApprovalsBloc>();
    
    approvalsBloc.add(
      ApprovalsEvent.commentsRequested(
        requestId: data.id,
        doctype: data.type.doctype,
      ),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: approvalsBloc,
        child: CommentsDialog(
          title: l10n.commentsLabel,
          subtitle: "${data.type.doctype} - ${data.id}",
        ),
      ),
    );
  }

  void _onEditTimesheet(BuildContext context) {
    final approvalsBloc = context.read<ApprovalsBloc>();
    approvalsBloc.add(ApprovalsEvent.editTimesheetRequested(requestId: data.id));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: approvalsBloc,
        child: const EditTimesheetBottomSheet(),
      ),
    );
  }

  void _onDeleteTimesheet(BuildContext context) {
    final approvalsBloc = context.read<ApprovalsBloc>();
    showDialog(
      context: context,
      builder: (context) => DeleteTimesheetDialog(
        requestId: data.id,
        onDelete: () {
          approvalsBloc.add(ApprovalsEvent.deleteTimesheetRequested(requestId: data.id));
        },
      ),
    );
  }
}
