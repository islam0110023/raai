import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';

void showAnimatedTopSnackBar(
  BuildContext context, {
  required String message,
  required String subMessage,
  bool isError = false,
}) {
  final overlay = Overlay.of(context);

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return _TopSnackBarWidget(
        message: message,
        subMessage: subMessage,
        isError: isError,
        onDismissed: () => overlayEntry.remove(),
      );
    },
  );

  overlay.insert(overlayEntry);
}

class _TopSnackBarWidget extends StatefulWidget {
  const _TopSnackBarWidget({
    required this.message,
    required this.onDismissed,
    required this.subMessage,
    required this.isError,
  });
  final String message;
  final String subMessage;
  final bool isError;
  final VoidCallback onDismissed;

  @override
  State<_TopSnackBarWidget> createState() => _TopSnackBarWidgetState();
}

class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  double dragOffset = 0;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      _controller.reverse().then((_) {
        widget.onDismissed();
      });
    });
  }

  void _dismissBySwipe() {
    _controller.reverse().then((_) {
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55 + dragOffset,
      left: 6,
      right: 6,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < 0) {
            setState(() {
              dragOffset += details.delta.dy;
            });
          }
        },
        onVerticalDragEnd: (details) {
          if (dragOffset.abs() > 10) {
            _dismissBySwipe();
          } else {
            setState(() {
              dragOffset = 0;
            });
          }
        },
        child: SlideTransition(
          position: _slideAnimation,
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              widget.onDismissed();
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.isError
                      ? AppColor.redLightHover
                      : AppColor.greenLightHover,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.shadowColor,
                      offset: Offset(0, 1),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: REdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 16,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: widget.isError
                        ? AppColor.redNormalActive
                        : AppColor.greenNormalActive,
                    radius: 25,
                    child: SvgPicture.asset(
                      widget.isError ? AppIcons.errorSnack : AppIcons.doneSnack,
                    ),
                  ),
                  title: Text(
                    widget.message,
                    style: widget.isError
                        ? AppTextStyles.s14.w400.redDarker
                        : AppTextStyles.s14.w400.greenDarker,
                  ),
                  subtitle: Padding(
                    padding: REdgeInsets.only(top: 5),
                    child: Text(
                      widget.subMessage,
                      style: widget.isError
                          ? AppTextStyles.s12.w300.redDarker
                          : AppTextStyles.s12.w300.greenDarker,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
