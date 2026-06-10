import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/presenation/manager/medication_form_cubit.dart';

class CustomCardUploadImage extends StatelessWidget {
  const CustomCardUploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'camera', child: Text('Camera')),
        PopupMenuItem(value: 'gallery', child: Text('Gallery')),
      ],
      color: Colors.white,
      offset: Offset(1, 90.h),
      menuPadding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      onSelected: (value) async {
        final picker = ImagePicker();
        final cubit = context.read<MedicationFormCubit>();

        if (value == 'camera') {
          final image = await picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            cubit.updateImage(image.path);
          }
        } else if (value == 'gallery') {
          final image = await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            cubit.updateImage(image.path);
          }
        }
      },
      child: BlocBuilder<MedicationFormCubit, InputMedicationModel>(
        builder: (context, state) {
          final imagePath = state.image;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: imagePath != null
                ? SizedBox(
                    key: ValueKey(imagePath),
                    height: 192.h,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32.r),
                      child: Image.file(File(imagePath), fit: BoxFit.cover),
                    ),
                  )
                : DottedBorder(
                    key: const ValueKey('placeholder'),
                    options: RoundedRectDottedBorderOptions(
                      color: AppColor.disableNormalHover,
                      strokeWidth: 2.r,
                      dashPattern: const [7, 7],
                      radius: Radius.circular(32.r),
                    ),
                    child: Container(
                      height: 192.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.addCamera),
                          const RSizedBox(height: 16),
                          Text(
                            'إضافة صورة الدواء',
                            style: AppTextStyles.s20.w600.subTextNormal,
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
