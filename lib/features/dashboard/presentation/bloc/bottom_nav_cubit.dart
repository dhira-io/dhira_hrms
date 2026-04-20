import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(homeIndex);

  /// Bottom navigation tab indices
  static const int homeIndex = 0;
  static const int attendanceIndex = 1;

  void changeIndex(int index) => emit(index);
}
