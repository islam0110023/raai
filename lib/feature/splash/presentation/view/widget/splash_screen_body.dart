import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/db/cache_helper/cache_helper.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> bgAnimation;
  late Animation<double> logoAnimation;
  late Animation<double> textOpacity;
  late Animation<double> textSlide;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: AppConstant.kDurationSplash),
    );
    bgAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    logoAnimation = Tween<double>(begin: 0, end: -100.h).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.7, curve: Curves.easeOut),
      ),
    );
    textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.7, 1, curve: Curves.easeIn),
      ),
    );
    textSlide = Tween<double>(begin: 20.h, end: -100.h).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.7, 1, curve: Curves.easeOut),
      ),
    );
    controller.forward();
    controller.addStatusListener((status) {
      if (status.isCompleted) {
        navigateToNextScreen();
      }
    });
  }

  void navigateToNextScreen() async {
    final isLoggedIn =
        await CacheHelper.getData(key: AppConstant.cacheKeyIsLoggedIn) ?? false;
    final isCaregiverLoggedIn =
        await CacheHelper.getData(
          key: AppConstant.cacheKeyCaregiverIsLoggedIn,
        ) ??
        false;

    if (!mounted) return;
    if (isCaregiverLoggedIn == true) {
      context.go(AppRoutes.homeScreenCaregiver);
      return;
    }

    if (isLoggedIn == true) {
      context.go(AppRoutes.homeScreen);
    } else {
      context.go(AppRoutes.onBoarding);
    }
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: [
            FadeTransition(
              opacity: bgAnimation,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.03, 0.3, .7],
                    colors: [
                      Color(0xffBCD78B),
                      Color(0xff5BAED8),
                      AppColor.disableDarkHover,
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 40.h),
                  Transform.translate(
                    offset: Offset(0, logoAnimation.value),
                    child: Image.asset(
                      AppImage.appLogo,
                      width: 156.r,
                      height: 155.r,
                    ),
                  ),
                  Opacity(
                    opacity: textOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, textSlide.value),
                      child: Text('راعي', style: AppTextStyles.s28.w700.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
