import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/custom_app_bar_app.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_card_upload_image.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_row_select_type_medicine.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_tab_bar_medication.dart';

class AddMedicationScreenBody extends StatelessWidget {
  const AddMedicationScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RSizedBox(height: 50),
          const CustomAppBarApp(title: 'إضافة دواء'),
          const RSizedBox(height: 16),
          const CustomCardUploadImage(),
          const RSizedBox(height: 16),
          Text(
            'سيساعدنا هذا في تذكيرك بشكل العلبة الصحيح',
            style: AppTextStyles.s14.w400.subTextNormal,
          ),
          const RSizedBox(height: 24),
          Row(
            spacing: 16.w,
            children: const [
              Expanded(
                child: AppTextField(
                  hint: 'مثال: بانادول',
                  isRequired: true,
                  label: 'اسم العلاج',
                ),
              ),
              Expanded(
                child: AppTextField(
                  hint: 'مثال: ضغط',
                  isRequired: true,
                  label: 'فئة العلاج',
                ),
              ),
            ],
          ),
          const RSizedBox(height: 24),
          Text('نوع العلاج', style: AppTextStyles.s16.w500.black),
          const RSizedBox(height: 16),
          const CustomRowSelectTypeMedicine(),
          const RSizedBox(height: 24),
          Text('معدل التكرار؟', style: AppTextStyles.s20.w700.black),
          const RSizedBox(height: 8),
          const CustomTabBarMedication(),
          const RSizedBox(height: 24),
          Text('وقت البدء',style: AppTextStyles.s16.w500.black,),
          

          Hero(
            tag: 'add-medication',
            child: AppButton.filled(text: 'حفظ الدواء', onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
