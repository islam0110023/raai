import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/widget/app_button_back.dart';
import 'package:raai/feature/onboarding/presentation/view/widget/custom_button_on_boarding.dart';
import 'package:raai/feature/onboarding/presentation/view/widget/on_boarding_view_1.dart';
import 'package:raai/feature/onboarding/presentation/view/widget/on_boarding_view_2.dart';
import 'package:raai/feature/onboarding/presentation/view/widget/on_boarding_view_3.dart';

class OnBoardingScreenBody extends StatefulWidget {
  const OnBoardingScreenBody({super.key});

  @override
  State<OnBoardingScreenBody> createState() => _OnBoardingScreenBodyState();
}

class _OnBoardingScreenBodyState extends State<OnBoardingScreenBody> {
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RSizedBox(height: 40),
          Visibility(
            visible: currentPage != 0,
            child: AppButtonBack(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
                setState(() {
                  currentPage--;
                });
              },
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                OnBoardingView1(),
                OnBoardingView2(),
                OnBoardingView3(),
              ],
            ),
          ),
          CustomButtonOnBoarding(
            onPressed: () {
              if (currentPage == 2) {
                context.go(AppRoutes.login);
                return;
              }
              pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn,
              );
              setState(() {
                currentPage++;
              });
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
