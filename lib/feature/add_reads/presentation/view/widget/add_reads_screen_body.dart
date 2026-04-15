import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/custom_app_bar_app.dart';
import 'package:raai/feature/add_reads/presentation/manager/add_read/add_reading_cubit.dart';
import 'package:raai/feature/add_reads/presentation/manager/add_reads_cubit.dart';
import 'package:raai/feature/add_reads/presentation/view/widget/custom_bloc_listener_add_reads.dart';
import 'package:raai/feature/add_reads/presentation/view/widget/custom_switch_add_reads.dart';

class AddReadsScreenBody extends StatelessWidget {
  const AddReadsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AddReadingCubit>();
    final cubit = context.watch<AddReadingCubit>();
    final state = context.watch<AddReadsCubit>();

    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RSizedBox(height: 55),
          CustomAppBarApp(
            title: 'إضافة قراءة',
            onPressed: () {
              context.pop<bool>(cubit.isSend);
            },
          ),
          const RSizedBox(height: 24),
          Text('اختر نوع القياس', style: AppTextStyles.s20.w600.subTextNormal),
          const RSizedBox(height: 24),
          const CustomSwitchAddReads(),
          const RSizedBox(height: 32),
          Visibility(
            visible: state.state.isBlood,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'إضافة قراءة سكر الدم',
                style: AppTextStyles.s20.w600.subTextNormal,
              ),
            ),
          ),
          Visibility(
            visible: !state.state.isBlood,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'إضافة قراءة ضغط الدم',
                style: AppTextStyles.s20.w600.subTextNormal,
              ),
            ),
          ),
          const RSizedBox(height: 27),
          Container(
            padding: REdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: AppColor.secondaryLightActive,
                width: 1.r,
              ),
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
              children: [
                Text('تعليمات سريعة', style: AppTextStyles.s16.w500.textNormal),
                const RSizedBox(height: 8),
                Visibility(
                  visible: state.state.isBlood,
                  child: Text(
                    '''- يُفضّل القياس قبل الأكل أو بعده بساعتين
- تأكّد إن إيدك نظيفة
- سجّل القراءة فور القياس''',
                    style: AppTextStyles.s14.w400.subTextNormal,
                    textAlign: TextAlign.center,
                  ),
                ),
                Visibility(
                  visible: !state.state.isBlood,
                  child: Text(
                    '''- اجلس بهدوء لمدة 5 دقائق
- ضع الجهاز على الذراع اليسرى
- لا تتكلم أثناء القياسس''',
                    style: AppTextStyles.s14.w400.subTextNormal,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const RSizedBox(height: 32),
          Text('ادخال البيانات', style: AppTextStyles.s20.w600.subTextNormal),
          const RSizedBox(height: 32),
          Visibility(
            visible: state.state.isBlood,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('mg/dL', style: AppTextStyles.s20.w600.subTextNormal),
                const RSizedBox(width: 4),
                SizedBox(
                  width: 128.w,
                  child: AppTextField(
                    hint: 'قيمة السكر',
                    textAlign: TextAlign.center,
                    controller: controller.sugarController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    padding: REdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !state.state.isBlood,
            child: Row(
              spacing: 8.w,
              children: [
                Expanded(
                  child: AppTextField(
                    hint: 'الضغط الانبساطي',
                    textAlign: TextAlign.center,
                    controller: controller.diastolicController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    padding: REdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 12,
                    ),
                  ),
                ),
                Text('/', style: AppTextStyles.s24.w700.black),
                Expanded(
                  child: AppTextField(
                    hint: 'الضغط الانقباضي',
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    controller: controller.systolicController,
                    padding: REdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const RSizedBox(height: 40),
          Visibility(
            visible: state.state.isBlood,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.alert),
                const RSizedBox(width: 10),
                Text(
                  'المعدل الطبيعي غالبًا بين 70 – 140',
                  style: AppTextStyles.s16.w500.subTextNormal,
                ),
              ],
            ),
          ),
          Visibility(
            visible: !state.state.isBlood,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.alert),
                const RSizedBox(width: 10),
                Text(
                  'القراءة الطبيعية غالبًا 80 / 120',
                  style: AppTextStyles.s16.w500.subTextNormal,
                ),
              ],
            ),
          ),
          const RSizedBox(height: 56),
          AppButton.filled(
            text: 'حفظ القراءة',
            onPressed: () {
              if (state.state.isBlood) {
                controller.addSugar();
              }
              if (!state.state.isBlood) {
                controller.addBlood();
              }
            },
          ),
          const CustomBlocListenerAddReads(),
        ],
      ),
    );
  }
}
