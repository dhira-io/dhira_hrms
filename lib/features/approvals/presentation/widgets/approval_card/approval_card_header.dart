import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'mini_status_badge.dart';

class ApprovalCardHeader extends StatelessWidget {
  final ApprovalRequestEntity data;

  const ApprovalCardHeader({
    super.key,
    required this.data,
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
          if (displayImage == null || displayImage!.isEmpty || displayImage == baseUrl) {
            final userImg = s.profile.userImage;
            if (userImg != null && userImg.isNotEmpty) {
              displayImage = userImg.startsWith('http') ? userImg : '$baseUrl$userImg';
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
          if (displayRole.isEmpty || displayImage == null || displayImage!.isEmpty || displayImage == baseUrl) {
            final emp = s.data.employees.firstWhere(
              (e) => (data.employeeId != null && e['name'] == data.employeeId) || e['employee_name'] == data.employeeName,
              orElse: () => <String, dynamic>{},
            );
            if (emp.isNotEmpty) {
              if (displayRole.isEmpty) displayRole = emp['designation'] ?? "";
              if (displayImage == null || displayImage!.isEmpty || displayImage == baseUrl) {
                final empImg = emp['image'];
                if (empImg != null && empImg.isNotEmpty) {
                  displayImage = empImg.startsWith('http') ? empImg : '$baseUrl$empImg';
                }
              }
            }
          }
        },
        orElse: () {},
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: AppConstants.p48,
          height: AppConstants.p48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.1), width: 2),
            image: DecorationImage(
              image: (displayImage != null && displayImage!.isNotEmpty)
                  ? NetworkImage(displayImage!) as ImageProvider
                  :  AssetImage(AppAssets.defaultProfile),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: AppConstants.p12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: AppTextStyle.labelLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.onSurface),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (displayRole.isNotEmpty)
                Text(
                  displayRole,
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        SizedBox(width: AppConstants.p8),
        MiniStatusBadge(status: data.status),
      ],
    );
  }
}
