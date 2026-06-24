import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  // Prevent instantiation
  ToastUtils._();

  /// Displays a basic success toast message.
  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.success,
      textColor: AppColors.white,
      fontSize: 14.0.sp,
    );
  }

  /// Displays a warning/error toast message.
  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.error,
      textColor: AppColors.white,
      fontSize: 14.0.sp,
    );
  }

  /// Displays a neutral information toast message.
  static void showInfo(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.slate500,
      textColor: AppColors.white,
      fontSize: 14.0.sp,
    );
  }
}

