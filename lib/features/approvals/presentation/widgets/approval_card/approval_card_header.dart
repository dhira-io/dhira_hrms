import 'package:dhira_hrms/features/approvals/data/constants/approvals_api_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/utils/string_utils.dart';
import 'mini_status_badge.dart';

class ApprovalCardHeader extends StatelessWidget {
  final ApprovalRequestEntity data;
  final bool isSelected;
  final Function(bool)? onSelectionChanged;

  const ApprovalCardHeader({
    super.key,
    required this.data,
    this.isSelected = false,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    String displayName = data.employeeName;
    String displayRole = data.employeeRole;
    String? displayImage = data.profileImage;

    if (data.category == ApprovalCategory.raised) {
      final profileState = context.read<ProfileBloc>().state;
      profileState.maybeMap(
        loaded: (s) {
          if (displayRole.isEmpty) displayRole = s.profile.designation ?? "";
          final baseUrl = ApiConstants.baseUrl.replaceAll(RegExp(r'/$'), '');
          if (displayImage == null ||
              displayImage!.isEmpty ||
              displayImage == baseUrl) {
            final userImg = s.profile.userImage;
            if (userImg != null && userImg.isNotEmpty) {
              displayImage = userImg.startsWith('http')
                  ? userImg
                  : '$baseUrl$userImg';
            }
          }
        },
        orElse: () {},
      );
    } else if (data.category == ApprovalCategory.team) {
      final approvalsState = context.read<ApprovalsBloc>().state;
      approvalsState.maybeMap(
        success: (s) {
          final baseUrl = ApiConstants.baseUrl.replaceAll(RegExp(r'/$'), '');
          if (displayRole.isEmpty ||
              displayImage == null ||
              displayImage!.isEmpty ||
              displayImage == baseUrl) {
            final emp = s.data.employees.firstWhere(
              (e) =>
                  (data.employeeId != null && e['name'] == data.employeeId) ||
                  e['employee_name'] == data.employeeName,
              orElse: () => <String, dynamic>{},
            );
            if (emp.isNotEmpty) {
              if (displayRole.isEmpty) displayRole = emp['designation'] ?? "";
              if (displayImage == null ||
                  displayImage!.isEmpty ||
                  displayImage == baseUrl) {
                final empImg = emp['image'];
                if (empImg != null && empImg.isNotEmpty) {
                  displayImage = empImg.startsWith('http')
                      ? empImg
                      : '$baseUrl$empImg';
                }
              }
            }
          }
        },
        orElse: () {},
      );
    }
    final bool isPending =
        data.status.toLowerCase().contains(ApprovalsApiConstants.statusPending);
    final bool showCheckbox = data.category == ApprovalCategory.team && isPending;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showCheckbox) ...[
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Checkbox(
              value: isSelected,
              onChanged: (value) {
                if (onSelectionChanged != null) {
                  onSelectionChanged!(value ?? false);
                }
              },
              activeColor: AppColors.of(context).primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.p12),
        ],
        Container(
          width: AppConstants.p48,
          height: AppConstants.p48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (displayImage == null || displayImage!.isEmpty)
                ? AppColors.of(context).primary
                : Colors.transparent,
            border: (displayImage != null && displayImage!.isNotEmpty)
                ? Border.all(
                    color: AppColors.of(context).primary.withValues(alpha: 0.1),
                    width: 2.w,
                  )
                : null,
          ),
          child: ClipOval(
            child: (displayImage != null && displayImage!.isNotEmpty)
                ? Image.network(
                    displayImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.of(context).primary,
                        child: Center(
                          child: Text(
                            displayName.isNotEmpty ? displayName.getInitials : "",
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
                      displayName.isNotEmpty ? displayName.getInitials : "",
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
                displayName,
                style: AppTextStyle.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.of(context).onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (displayRole.isNotEmpty)
                Text(
                  displayRole,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        const SizedBox(width: AppConstants.p8),
        MiniStatusBadge(status: data.status),
      ],
    );
  }
}
