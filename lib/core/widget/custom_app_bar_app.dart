import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button_back.dart';

class CustomAppBarApp extends StatelessWidget {
  const CustomAppBarApp({
    super.key,
    required this.title,
    this.onPressed,
    this.isLabel,
  });
  final String title;
  final VoidCallback? onPressed;
  final bool? isLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppButtonBack(
          onPressed:
              onPressed ??
              () {
                context.pop();
              },
          isLabel: isLabel ?? false,
        ),
        Text(title, style: AppTextStyles.s28.w700.textNormal),
        const RSizedBox(width: 45),
      ],
    );
  }
}
