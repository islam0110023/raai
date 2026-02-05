import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/utils/app_icons.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());
  int currentIndex = 0;
  bool isChat = false;
  List<bool> isSelected = [true, false, false, false, false];

  void changeIndex(int index) {
    currentIndex = index;
    isChat = index == 2;
    isSelected[index] = true;
    emit(BottomNavInitial());
  }

  void changeChat() {
    isChat = !isChat;
    emit(BottomNavInitial());
  }

  final items = [
    {'icon': AppIcons.home, 'label': 'الرئيسيه'},
    {'icon': AppIcons.medicine, 'label': 'الادويه'},
    {'icon': AppIcons.robot, 'label': 'حادثني'},
    {'icon': AppIcons.medical, 'label': 'القياسات'},
    {'icon': AppIcons.person, 'label': 'معلوماتي'},
  ];
}
