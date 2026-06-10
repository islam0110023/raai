import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raai/core/utils/styling.dart';

class RemainingTimeWidget extends StatefulWidget {
  const RemainingTimeWidget({super.key, this.medicationDate});

  final DateTime? medicationDate;

  @override
  State<RemainingTimeWidget> createState() => _RemainingTimeWidgetState();
}

class _RemainingTimeWidgetState extends State<RemainingTimeWidget> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(minutes: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String getRemainingTime() {
    final difference = widget.medicationDate!.difference(DateTime.now());

    if (difference.isNegative) {
      return 'الأن';
    }

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    if (hours > 0) {
      return '$hoursس $minutesد';
    }

    return '$minutesد';
  }

  @override
  Widget build(BuildContext context) {
    return Text(getRemainingTime(), style: AppTextStyles.s14.w400.white);
  }
}
