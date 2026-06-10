import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/presenation/manager/medication_form_cubit.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_card_medicine_type.dart';

class CustomRowSelectTypeMedicine extends StatelessWidget {
  const CustomRowSelectTypeMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicationFormCubit, InputMedicationModel>(
      builder: (context, state) {
        return Row(
          spacing: 16.w,
          children: [
            Expanded(
              child: CustomCardMedicineType(
                title: 'كبسولات',
                icon: AppIcons.tablet,
                isSelected: state.form == 'TABLET',
                onTap: () {
                  context.read<MedicationFormCubit>().updateForm('TABLET');
                },
              ),
            ),
            Expanded(
              child: CustomCardMedicineType(
                title: 'حقن',
                icon: AppIcons.injectionMedicine,
                isSelected: state.form == 'INJECTION',
                onTap: () {
                  context.read<MedicationFormCubit>().updateForm('INJECTION');
                },
              ),
            ),
            Expanded(
              child: CustomCardMedicineType(
                title: 'شرب',
                icon: AppIcons.waterMedicine,
                isSelected: state.form == 'SYRUP',
                onTap: () {
                  context.read<MedicationFormCubit>().updateForm('SYRUP');
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
