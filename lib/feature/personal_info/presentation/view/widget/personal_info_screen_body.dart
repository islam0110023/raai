import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/feature/personal_info/presentation/view/widget/custom_container_personal_info_upper.dart';
import 'package:raai/feature/personal_info/presentation/view/widget/custom_image_personal_info.dart';
import 'package:raai/feature/personal_info/presentation/view/widget/custom_select_gender_personal_info.dart';

class PersonalInfoScreenBody extends StatelessWidget {
  const PersonalInfoScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomContainerPersonalInfoUpper(),
        const CustomImagePersonalInfo(),
        Positioned(
          top: 335.h,
          left: 16.w,
          right: 16.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTextField(
                hint: 'ادخل الاسم الاول',
                label: 'الاسم الاول',
                isRequired: true,
                prefixIcon: CupertinoIcons.person,
              ),
              const RSizedBox(height: 16),
              const AppTextField(
                hint: 'ادخل الاسم الاخير',
                label: 'الاسم الاخير',
                isRequired: true,
                prefixIcon: CupertinoIcons.person,
              ),
              const RSizedBox(height: 16),
              AppTextField(
                hint: 'حدد تاريخ ميلادك',
                label: 'تاريخ الميلاد',
                isRequired: true,
                prefixIcon: Icons.calendar_today_outlined,
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                },
              ),
              const RSizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: 'النوع',
                  style: AppTextStyles.s16.w500.textDark,
                  children: const [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const RSizedBox(height: 16),
              const CustomSelectGenderPersonalInfo(),
              const RSizedBox(height: 24),
              AppButton.filled(
                text: 'التالي',
                onPressed: () {
                  context.push(AppRoutes.selectRole);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
