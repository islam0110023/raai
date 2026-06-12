import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.child,
    this.highlightColor,
    this.baseColor,
  });
  final Widget? child;
  final double? width, height;
  final double? radius;
  final Color? color;
  final Color? highlightColor;
  final Color? baseColor;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      child:
          child ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 15.r),
              color: color ?? Colors.white60,
            ),
          ),
    );
  }
}
