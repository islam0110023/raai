import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';

class CustomCardCaregiversList extends StatefulWidget {
  const CustomCardCaregiversList({
    super.key,
    this.isRead = false,
    required this.title,
    required this.subtitle,
    required this.status,
    this.onCall,
    this.onDelete,
    this.onEdit,
  });
  final bool isRead;
  final String title;
  final String subtitle;
  final String status;
  final VoidCallback? onCall;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  State<CustomCardCaregiversList> createState() =>
      _CustomCardCaregiversListState();
}

class _CustomCardCaregiversListState extends State<CustomCardCaregiversList>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCirc,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadowColor,
            offset: Offset(0, 0),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.isRead)
                  CircleAvatar(
                    radius: 5.r,
                    backgroundColor: AppColor.secondaryNormal,
                  ),
                const RSizedBox(width: 10),
                Image.asset(AppImage.avatarMale, width: 48.r, height: 48.r),
              ],
            ),
            title: Padding(
              padding: REdgeInsets.only(bottom: 5),
              child: Text(
                widget.title,
                style: AppTextStyles.s14.w400.primaryNormal,
              ),
            ),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.subtitle,
                    style: AppTextStyles.s12.w300.subTextNormal,
                  ),
                  // TextSpan(
                  //   text: ' - ',
                  //   style: AppTextStyles.s12.w300.subTextNormal,
                  // ),
                  // TextSpan(
                  //   text: widget.status,
                  //   style: AppTextStyles.s12.w300.subTextNormal,
                  // ),
                ],
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              icon: isExpanded
                  ? SvgPicture.asset(AppIcons.menuHer)
                  : SvgPicture.asset(AppIcons.menuVertical),
              padding: EdgeInsets.zero,
            ),
            contentPadding: REdgeInsets.only(
              top: 0,
              bottom: 0,
              left: 4,
              right: 10,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeInOutCirc,
            switchOutCurve: Curves.easeInOutCirc,
            reverseDuration: const Duration(milliseconds: 100),
            transitionBuilder: (child, animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0, -0.2),
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: offsetAnimation, child: child),
              );
            },
            child: isExpanded
                ? Padding(
                    key: const ValueKey('expanded'),
                    padding: REdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton.outline(
                            text: 'الاتصال',
                            onPressed: widget.onCall,
                            borderColor: AppColor.primaryDarkHover,
                            textStyle: AppTextStyles.s12.w300.primaryDarker,
                            radius: 12,
                            borderWidth: 1.r,
                            isOutlineColor: false,
                            textColor: AppColor.primaryDarkHover,
                            padding: REdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                        SizedBox(width: 7.5.r),
                        Expanded(
                          child: AppButton.outline(
                            text: 'تعيين كأساسي',
                            onPressed: widget.onEdit,
                            borderColor: AppColor.primaryDarkHover,
                            textStyle: AppTextStyles.s12.w300.primaryDarker,
                            radius: 12,
                            borderWidth: 1.r,
                            isOutlineColor: false,
                            textColor: AppColor.primaryDarkHover,
                            padding: REdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                        SizedBox(width: 7.5.r),
                        Expanded(
                          child: AppButton.outline(
                            text: 'ازاله المرافق',
                            onPressed: widget.onDelete,
                            borderColor: AppColor.redDarkHover,
                            textStyle: AppTextStyles.s12.w300.redDarker,
                            radius: 12,
                            borderWidth: 1.r,
                            isOutlineColor: false,
                            textColor: AppColor.redNormalHover,
                            padding: REdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(key: ValueKey('collapsed')),
          ),
        ],
      ),
    );
  }
}
