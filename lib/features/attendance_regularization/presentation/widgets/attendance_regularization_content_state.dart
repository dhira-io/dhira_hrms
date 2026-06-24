import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/attendance_regularization_state.dart';
import 'attendance_regularization_form_widget.dart';
import 'attendance_regularization_review_widget.dart';
import 'attendance_regularization_success_widget.dart';

class AttendanceRegularizationContentState extends StatelessWidget {
  final AttendanceRegularizationState state;
  final VoidCallback onMyRequestsPressed;
  final VoidCallback onBackToHomePressed;
  final RegularizationFormConfig formConfig;

  const AttendanceRegularizationContentState({
    super.key,
    required this.state,
    required this.onMyRequestsPressed,
    required this.onBackToHomePressed,
    required this.formConfig,
  });

  @override
  Widget build(BuildContext context) {
    final currentStep = state.currentStep;

    if (currentStep == 2) {
      return AttendanceRegularizationSuccessWidget(
        onMyRequests: onMyRequestsPressed,
        onBackToHome: onBackToHomePressed,
      );
    }

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 18.h),
      child: currentStep == 1
          ? AttendanceRegularizationReviewWidget(
              formData: state.formData,
              managerName: state.managerName,
            )
          : AttendanceRegularizationFormWidget(
              config: formConfig,
            ),
    );
  }
}
