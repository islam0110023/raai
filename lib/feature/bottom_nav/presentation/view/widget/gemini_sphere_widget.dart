import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeminiSphereWidget extends StatefulWidget {
  const GeminiSphereWidget({super.key, required this.amplitude});
  final double amplitude;

  @override
  State<GeminiSphereWidget> createState() => _GeminiSphereWidgetState();
}

class _GeminiSphereWidgetState extends State<GeminiSphereWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(260.r, 260.r),
          painter: GeminiSpherePainter(
            animationValue: _controller.value,
            amplitude: widget.amplitude,
          ),
        );
      },
    );
  }
}

class GeminiSpherePainter extends CustomPainter {
  GeminiSpherePainter({required this.animationValue, required this.amplitude});
  final double animationValue;
  final double amplitude;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = (size.width / 3.4) + (amplitude * 20);

    final glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 35)
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF9B51E0).withAlpha(120),
          const Color(0xFF2F80ED).withAlpha(80),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius * 1.6));

    canvas.drawCircle(center, baseRadius * 1.3, glowPaint);

    _drawLiquidBlob(canvas, center, baseRadius, 8, 0.0, [
      const Color(0xFF4285F4),
      const Color(0xFF9B51E0),
    ]);

    _drawLiquidBlob(canvas, center, baseRadius * 0.94, 6, math.pi / 2, [
      const Color(0xFFEC407A),
      const Color(0xFF2F80ED),
    ]);

    _drawLiquidBlob(canvas, center, baseRadius * 0.88, 5, math.pi, [
      const Color(0xAA8000FF),
      const Color(0xCC4285F4),
    ]);
  }

  void _drawLiquidBlob(
    Canvas canvas,
    Offset center,
    double radius,
    int waveCount,
    double phaseShift,
    List<Color> colors,
  ) {
    final Path path = Path();
    const int resolution = 120;
    final double angleStep = (math.pi * 2) / resolution;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    for (int i = 0; i <= resolution; i++) {
      final double angle = i * angleStep;
      final double waveModulation =
          math.sin(
            angle * waveCount + (animationValue * math.pi * 2) + phaseShift,
          ) *
          (6.0 + (amplitude * 15.0));

      final double currentRadius = radius + waveModulation;
      final double x = center.dx + math.cos(angle) * currentRadius;
      final double y = center.dy + math.sin(angle) * currentRadius;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant GeminiSpherePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.amplitude != amplitude;
  }
}
