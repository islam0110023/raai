import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_select_role.dart';

class CustomListSelectRole extends StatefulWidget {
  const CustomListSelectRole({super.key});

  @override
  State<CustomListSelectRole> createState() => _CustomListSelectRoleState();
}

class _CustomListSelectRoleState extends State<CustomListSelectRole> {
  bool isUser = true;
  bool isSon = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Row(
        spacing: 102.w,
        children: [
          Expanded(
            child: CustomSelectRole(
              value: isSon,
              image: AppImage.son,
              title: 'مرافق',
              onTap: () {
                setState(() {
                  isSon = true;
                  isUser = false;
                });
              },
              onChanged: (value) {
                setState(() {
                  isSon = true;
                  isUser = false;
                });
              },
            ),
          ),
          Expanded(
            child: CustomSelectRole(
              value: isUser,
              image: AppImage.father,
              title: 'مستخدم',
              onTap: () {
                setState(() {
                  isUser = true;
                  isSon = false;
                });
              },
              onChanged: (value) {
                setState(() {
                  isUser = true;
                  isSon = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
