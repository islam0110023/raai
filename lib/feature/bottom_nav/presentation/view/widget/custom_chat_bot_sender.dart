import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/chat_bot/presentation/manager/chat_bot_cubit.dart';

class CustomChatBotSender extends StatelessWidget {
  const CustomChatBotSender({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ChatBotCubit>();
    final state = context.watch<ChatBotCubit>();

    return Container(
      margin: REdgeInsets.only(
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom == 0
            ? 8
            : MediaQuery.of(context).viewInsets.bottom,
        left: 26,
        right: 26,
      ),
      padding: REdgeInsets.only(left: 16),

      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadowColor,
            spreadRadius: 0,
            blurRadius: 12,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTapUpOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: controller.textEditingController,
              cursorColor: AppColor.black,
              decoration: InputDecoration(
                fillColor: AppColor.white,
                filled: true,
                hint: Text(
                  'اكتب هنا.....',
                  style: AppTextStyles.s14.w400.disableNormal,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.attachment),
              const RSizedBox(width: 8),
              SvgPicture.asset(AppIcons.microphone),
              const RSizedBox(width: 8),
              InkWell(
                onTap: () {
                  if (controller.textEditingController.text.isEmpty) return;
                  if (state.messages.last.isLoading) return;
                  controller.addMessage(controller.textEditingController.text);
                  controller.getMessages(sessionId: 'user123');
                  controller.textEditingController.clear();
                },
                child: SvgPicture.asset(AppIcons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
