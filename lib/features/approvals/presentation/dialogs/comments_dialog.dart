import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_state.dart';
import 'widgets/comment_item.dart';

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
    final l10n = AppLocalizations.of(context)!;

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
                final comments = s.data.comments;
                final isLoading = s.data.isCommentsLoading;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(title, style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.p4),
                    Text(subtitle, style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).onSurfaceVariant)),
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
                          child: Text(l10n.noCommentsFound, style: AppTextStyle.bodyMedium),
                        ),
                      )
                    else
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: comments.length,
                          itemBuilder: (context, index) => CommentItem(comment: comments[index]),
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
