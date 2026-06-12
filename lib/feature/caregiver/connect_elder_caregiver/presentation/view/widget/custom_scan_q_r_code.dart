import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/presentation/manager/connect_elder_caregiver/connect_elder_caregiver_cubit.dart';
import 'package:raai/feature/caregivers/presentation/view/widget/custom_show_qr_code.dart';

class CustomScanQRCode extends StatelessWidget {
  const CustomScanQRCode({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConnectElderCaregiverCubit>();
    return BlocBuilder<ConnectElderCaregiverCubit, ConnectElderCaregiverState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(size: Size(230.r, 230.r), painter: QRBorderPainter()),
            if (cubit.isScanning)
              SizedBox(
                height: 200.r,
                width: 200.r,
                child: MobileScanner(
                  controller: cubit.mobileScannerController,
                  onDetect: (barcodes) async {
                    if (cubit.isScanned) return;

                    cubit.isScanned = true;

                    final code = barcodes.barcodes.first.rawValue;

                    if (code == null) return;
                    await cubit.onQrScanned(code);
                  },
                ),
              ),
            if (!cubit.isScanning) ...[
              Image.asset(AppImage.qrCode, width: 230.w, height: 230.h),
              InkWell(
                onTap: () {
                  cubit.startScanning();
                },
                borderRadius: BorderRadius.circular(24.r),
                splashColor: AppColor.primaryDarkActive,
                highlightColor: AppColor.primaryDarkActive,
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xadF8F8F8),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: AppColor.subtextLightHover,
                      width: 1.r,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        CupertinoIcons.photo_camera,
                        color: AppColor.primaryDarkActive,
                      ),
                      const RSizedBox(height: 4),
                      Text(
                        'اضغط للمسح',
                        style: AppTextStyles.s14.w400.primaryDarkActive,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
