import 'package:dhira_hrms/utils/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {


  static void showToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.black,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }
}
