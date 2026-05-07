import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_state.dart';

class CommentsDialog extends StatelessWidget {
  final String title;
  final String subtitle;

  const CommentsDialog({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r16)),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.p24),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          maxWidth: 500,
        ),
        child: BlocBuilder<ApprovalsBloc, ApprovalsState>(
          builder: (context, state) {
            return state.maybeMap(
              success: (s) {
                final comments = s.comments;
                final isLoading = s.isCommentsLoading;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.p4),
                    Text(subtitle, style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: AppConstants.p24),
                    if (isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppConstants.p24),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (comments.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppConstants.p24),
                          child: Text('No comments found', style: AppTextStyle.bodyMedium),
                        ),
                      )
                    else
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: comments.length,
                          separatorBuilder: (_, __) => const SizedBox(height: AppConstants.p16),
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return Container(
                              padding: const EdgeInsets.all(AppConstants.p16),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLow,
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
                                        style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppConstants.p8),
                                  Text(comment.content, style: AppTextStyle.bodyMedium),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
