import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/manager/all_medication_caregiver/all_medication_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/view/widget/all_medication_caregiver_view_body.dart';

class AllMedicationCaregiverView extends StatelessWidget {
  const AllMedicationCaregiverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllMedicationCaregiverCubit(getIt()),
      child: const AllMedicationCaregiverViewBody(),
    );
  }
}
