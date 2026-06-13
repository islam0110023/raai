import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:raai/core/utils/app_color.dart';

class CustomShowQrCode extends StatelessWidget {
  const CustomShowQrCode({super.key});

  @override
  Widget build(BuildContext context) {
    final elderCode = GoRouterState.of(context).extra ?? '' as String?;
    return Stack(
      alignment: Alignment.center,
      children: [
        QrImageView(
          data: elderCode.toString(),
          size: 200.r,
          version: QrVersions.auto,
        ),
        CustomPaint(size: Size(230.r, 230.r), painter: QRBorderPainter()),
      ],
    );
  }
}

class QRBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.primaryNormal
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double cornerLength = 30;

    /// top-left
    canvas.drawLine(const Offset(0, 0), Offset(cornerLength, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(0, cornerLength), paint);

    /// top-right
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, cornerLength),
      paint,
    );

    /// bottom-left
    canvas.drawLine(
      Offset(0, size.height),
      Offset(cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - cornerLength),
      paint,
    );

    /// bottom-right
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
