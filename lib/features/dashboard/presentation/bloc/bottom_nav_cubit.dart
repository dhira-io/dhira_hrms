import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(homeIndex);

  /// Bottom navigation tab indices
  static const int homeIndex = 0;
  static const int attendanceIndex = 1;
  static const int approvalsIndex = 2;
  static const int myOrgIndex = 3;
  static const int settingsIndex = 4;

  void changeIndex(int index) => emit(index);
}
