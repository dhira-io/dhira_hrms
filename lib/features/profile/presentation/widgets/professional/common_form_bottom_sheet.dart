import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/widgets/common_button.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_state.dart';

class CommonFormBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final VoidCallback onSave;
  final ProfileBloc bloc;
  final GlobalKey<FormState>? formKey;

  const CommonFormBottomSheet({
    super.key,
    required this.title,
    required this.fields,
    required this.onSave,
    this.formKey,
    required this.bloc,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required List<Widget> fields,
    required VoidCallback onSave,
    GlobalKey<FormState>? formKey,
    required ProfileBloc bloc,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.of(context).surface
          : AppColors.of(context).white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext sheetContext) {
        return CommonFormBottomSheet(
          title: title,
          fields: fields,
          onSave: onSave,
          formKey: formKey,
          bloc: bloc,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // We add padding for keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: fields,
    );

    if (formKey != null) {
      content = Form(key: formKey, child: content);
    }

    return SafeArea(
      bottom: true,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: bloc,
        listener: (context, state) {
          state.maybeWhen(
            success: (_, __, ___) {
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

          return Container(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 24.h,
              bottom: bottomInset + 24.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyle.h3.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Form Content
                Flexible(child: SingleChildScrollView(child: content)),

                SizedBox(height: 24.h),

                // Actions
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        text: l10n.cancel,
                        onPressed: () => Navigator.pop(context),
                        variant: ButtonVariant.outlined,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CommonButton(
                        text: isLoading ? l10n.saving : l10n.save,
                        onPressed: isLoading ? null : onSave,
                        isLoading: isLoading,
                        variant: ButtonVariant.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Helper to show a [CommonFormBottomSheet] with less boilerplate.
Future<T?> _showBottomSheet<T>({
  required BuildContext context,
  required String title,
  required List<Widget> fields,
  required VoidCallback onSave,
  GlobalKey<FormState>? formKey,
  required ProfileBloc bloc,
}) {
  return CommonFormBottomSheet.show<T>(
    context: context,
    title: title,
    fields: fields,
    onSave: onSave,
    formKey: formKey,
    bloc: bloc,
  );
}
