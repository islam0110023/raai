import 'package:flutter/material.dart';
import 'package:raai/feature/personal_info/presentation/view/widget/personal_info_screen_body.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PersonalInfoScreenBody(),
      resizeToAvoidBottomInset: false,
    );
  }
}
