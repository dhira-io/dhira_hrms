import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/widgets/common_button.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_state.dart';

class CommonFormDialog extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final VoidCallback onSave;
  final ProfileBloc bloc;

  final GlobalKey<FormState>? formKey;

  const CommonFormDialog({
    super.key,
    required this.title,
    required this.fields,
    required this.onSave,
    this.formKey,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: fields,
    );

    if (formKey != null) {
      content = Form(key: formKey, child: content);
    }

    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          success: (_, _, _) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          uploading: (_, __) => true,
          orElse: () => false,
        );

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
          titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
          title: Text(
            title,
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          content: SingleChildScrollView(child: content),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonButton(
                  text: isLoading ? l10n.saving : l10n.save,
                  onPressed: isLoading ? null : onSave,
                  icon: isLoading ? null : Icons.save_outlined,
                  isLoading: isLoading,
                  variant: ButtonVariant.primary,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  width: null,
                ),
                SizedBox(width: 12.w),
                CommonButton(
                  text: l10n.cancel,
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.close,
                  variant: ButtonVariant.outlined,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
