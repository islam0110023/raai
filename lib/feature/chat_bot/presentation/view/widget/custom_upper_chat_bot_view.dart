import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button_back.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/bottom_nav_cubit.dart';

class CustomUpperChatBotView extends StatelessWidget {
  const CustomUpperChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BottomNavCubit>();

    return Row(
      children: [
        AppButtonBack(
          onPressed: () {
            controller.changeChat();
          },
          isLabel: false,
        ),
        Expanded(
          child: ListTile(
            leading: SvgPicture.asset(AppIcons.chatBot, fit: BoxFit.none),
            title: Text('الراعي الذكي', style: AppTextStyles.s20.w600.blue),
            subtitle: Row(
              children: [
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    color: AppColor.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                const RSizedBox(width: 4),
                Text('متاح', style: AppTextStyles.s16.w500.green),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
