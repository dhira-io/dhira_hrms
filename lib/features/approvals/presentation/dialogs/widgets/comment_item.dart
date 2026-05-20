import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/comment_entity.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;

  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.p16),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.p16),
        decoration: BoxDecoration(
          color: AppColors.of(context).surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    comment.commentBy ?? comment.owner,
                    style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  DateTimeUtils.formatDate(comment.creation, pattern: 'dd-MM-yyyy'),
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.p8),
            Text(comment.content, style: AppTextStyle.bodyMedium),
          ],
        ),
      ),
    );
  }
}
