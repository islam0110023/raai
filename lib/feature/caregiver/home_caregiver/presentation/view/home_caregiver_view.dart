import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/manager/home_caregiver/home_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/view/widget/home_caregiver_body_view.dart';

class HomeCaregiverView extends StatelessWidget {
  const HomeCaregiverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCaregiverCubit(getIt()),
      child: const HomeCaregiverBodyView(),
    );
  }
}
