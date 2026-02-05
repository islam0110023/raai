import 'package:flutter/material.dart';
import 'package:raai/core/utils/styling.dart';

class ComingSoonBody extends StatelessWidget {
  const ComingSoonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        Text('قريبا', style: AppTextStyles.s28.w700.textNormal),
      ],
    );
  }
}
