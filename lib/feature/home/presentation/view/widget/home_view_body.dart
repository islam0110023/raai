import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_card_medicine_home.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_card_online_caregiver.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_layout_in_home_view.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_status_home_view.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_upper_home_view.dart';
import 'package:raai/feature/profile/presentation/view/widget/custom_card_last_read_no_data.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const RSizedBox(height: 50),
          const CustomUpperHomeView(),
          const RSizedBox(height: 8),
          const CustomStatusHomeView(),
          const RSizedBox(height: 16),
          Row(
            spacing: 20.w,
            children: const [
              Expanded(child: CustomCardLastReadNoData(isBlood: true)),
              Expanded(child: CustomCardLastReadNoData(isBlood: false)),
            ],
          ),
          const RSizedBox(height: 16),
          Text('الدواء القادم', style: AppTextStyles.s16.w500.textNormal),
          const RSizedBox(height: 16),
          const CustomCardMedicineHome(),
          const RSizedBox(height: 16),
          Text('أختصارات', style: AppTextStyles.s16.w500.textNormal),
          const RSizedBox(height: 16),
          const CustomLayoutInHomeView(),
          const RSizedBox(height: 16),
          Text('مرافقين متصلين', style: AppTextStyles.s16.w500.textNormal),
          const RSizedBox(height: 16),
          const CustomCardOnlineCaregiver(),
          const RSizedBox(height: 130),
        ],
      ),
    );
  }
}
