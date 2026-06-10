import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/custom_app_bar_app.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/medication/presenation/manager/add_medication/add_medication_cubit.dart';
import 'package:raai/feature/medication/presenation/manager/medication_form_cubit.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_card_upload_image.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_row_select_type_medicine.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_step_start_time.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_tab_bar_medication.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_tabs_bar_with_food.dart';

class AddMedicationScreenBody extends StatelessWidget {
  const AddMedicationScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicationFormCubit>();
    final state = context.watch<MedicationFormCubit>();
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
            children: [
              Expanded(
                child: AppTextField(
                  hint: 'مثال: بانادول',
                  isRequired: true,
                  label: 'اسم العلاج',
                  onChanged: (value) {
                    cubit.updateName(value);
                  },
                ),
              ),
              Expanded(
                child: AppTextField(
                  hint: 'مثال: ضغط',
                  isRequired: true,
                  label: 'فئة العلاج',
                  onChanged: (value) {
                    cubit.updateCategory(value);
                  },
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
          const RSizedBox(height: 8),
          Text('وقت البدء', style: AppTextStyles.s16.w500.black),
          const RSizedBox(height: 8),
          const CustomStepStartTime(),
          const RSizedBox(height: 24),
          Text('مع الأكل؟', style: AppTextStyles.s20.w700.textNormal),
          const RSizedBox(height: 8),
          const CustomTabsBarWithFood(),
          const RSizedBox(height: 24),
          AppTextField(
            hint: 'مثال: 3',
            label: state.state.form == 'SYRUP'
                ? 'كام كوب في الجرعة الواحدة'
                : state.state.form == 'INJECTION'
                ? 'عدد الحقن في الجرعة الواحدة'
                : 'عدد الحبات في الجرعه الواحدة',
            padding: REdgeInsets.symmetric(horizontal: 36),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            onChanged: (value) {
              cubit.updatePillsPerDose(value);
            },
          ),
          const RSizedBox(height: 24),

          AppTextField(
            hint: 'مثال: 14',
            label: state.state.form == 'SYRUP'
                ? 'كام كوب'
                : state.state.form == 'INJECTION'
                ? 'عدد الحقن'
                : 'عدد حبات الدواء',
            padding: REdgeInsets.symmetric(horizontal: 36),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            onChanged: (value) {
              cubit.updateTotalPills(value);
            },
          ),
          const RSizedBox(height: 34),

          Hero(
            tag: 'add-medication',
            child: AppButton.filled(
              text: 'حفظ الدواء',
              onPressed: () async {
                final state = context.read<MedicationFormCubit>().state;
                final validationMessage = state.validationMessage;
                if (validationMessage != null) {
                  showAnimatedTopSnackBar(
                    context,
                    message: 'نسيت حقل',
                    subMessage: validationMessage,
                    isError: true,
                  );
                  return;
                }
                await context.read<AddMedicationCubit>().createMedication(
                  state,
                );
              },
            ),
          ),
          const RSizedBox(height: 24),
          BlocListener<AddMedicationCubit, AddMedicationState>(
            listener: (context, state) {
              if (state is AddMedicationSuccess) {
                if (context.canPop()) {
                  context.pop();
                }
                showAnimatedTopSnackBar(
                  context,
                  message: 'نجحت',
                  subMessage: 'تم اضافة الدواء بنجاح',
                );
              }
              if (state is AddMedicationFailure) {
                if (context.canPop()) {
                  context.pop();
                }
                showAnimatedTopSnackBar(
                  context,
                  message: 'فشلت',
                  subMessage: state.message,
                  isError: true,
                );
              }
              if (state is AddMedicationLoading) {
                AppConstant.showLoadingDialog(context);
              }
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
