import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/caregiver/profile_caregiver/presentation/manager/profile_caregiver/profile_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/profile_caregiver/presentation/view/widget/profile_caregiver_view_body.dart';

class ProfileCaregiverView extends StatelessWidget {
  const ProfileCaregiverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCaregiverCubit(getIt()),
      child: const ProfileCaregiverViewBody(),
    );
  }
}
