import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';

class CustomConfirmUpperAnimation extends StatefulWidget {
  const CustomConfirmUpperAnimation({super.key});

  @override
  State<CustomConfirmUpperAnimation> createState() =>
      _CustomConfirmUpperAnimationState();
}

class _CustomConfirmUpperAnimationState
    extends State<CustomConfirmUpperAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: Container(
        width: 200.r,
        height: 200.r,
        decoration: const ShapeDecoration(
          shape: OvalBorder(),
          shadows: [
            BoxShadow(
              color: AppColor.secondaryNormal,
              blurRadius: 30,
              offset: Offset(0, 0),
              spreadRadius: 8,
            ),
          ],
          gradient: RadialGradient(
            colors: [AppColor.primaryLightHover, AppColor.primaryNormal],
          ),
        ),
        child: Icon(Icons.done, size: 100.r, color: AppColor.white),
      ),
    );
  }
}
