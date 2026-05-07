import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_card_medication.dart';

class MedicationViewBody extends StatelessWidget {
  const MedicationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RSizedBox(height: 50),
          Text(
            'قائمة أدويتك اليومية',
            style: AppTextStyles.s24.w700.textNormal,
          ),
          const RSizedBox(height: 8),
          Text(
            'اضغط علي الدواء لعرض مزيد من الخيارات',
            style: AppTextStyles.s14.w400.subTextNormal,
          ),
          const RSizedBox(height: 16),
          const CustomCardMedication(),
        ],
      ),
    );
  }
}

