import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/widget/shimmer_effect.dart';

class CustomCardOfReadsLoading extends StatelessWidget {
  const CustomCardOfReadsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      itemCount: 10,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: REdgeInsets.fromLTRB(16, 12, 16, 110),
      itemBuilder: (context, index) {
        return Container(
          padding: REdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: AppColor.white,
            boxShadow: const [
              BoxShadow(
                color: AppColor.shadowColor,
                blurRadius: 12,
                offset: Offset(0, 0),
                spreadRadius: 3,
              ),
            ],
          ),
          child: ClipRect(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ShimmerEffect(width: 100, height: 24, radius: 0),
                const RSizedBox(height: 12),

                const ShimmerEffect(width: 112, height: 35, radius: 0),
                const RSizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.w,
                  children: const [
                    ShimmerEffect(width: 53, height: 20, radius: 0),
                    ShimmerEffect(width: 16, height: 16, radius: 100),
                  ],
                ),
                const RSizedBox(height: 12),
                const ShimmerEffect(width: 137, height: 15, radius: 8),

                const RSizedBox(height: 8),
                ShimmerEffect(width: 148.w, height: 32.h),
              ],
            ),
          ),
        );
      },
      crossAxisCount: 2,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
    );
  }
}
