import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/utils/app_icons.dart';

part 'bottom_nav_caregiver_state.dart';

class BottomNavCaregiverCubit extends Cubit<BottomNavCaregiverState> {
  BottomNavCaregiverCubit() : super(BottomNavCaregiverInitial());
  int currentIndex = 0;
  List<bool> isSelected = [true, false, false];
  void changeIndex(int index) {
    currentIndex = index;
    isSelected[index] = true;
    emit(BottomNavCaregiverInitial());
  }

  final items = [
    {'icon': AppIcons.home, 'label': 'الرئيسيه'},
    {'icon': AppIcons.medicine, 'label': 'الادويه'},
    {'icon': AppIcons.person, 'label': 'معلوماتي'},
  ];
}
