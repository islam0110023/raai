import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/medication/presenation/manager/medications_data/medications_data_cubit.dart';
import 'package:raai/feature/medication/presenation/view/widget/medication_view_body.dart';

class MedicationView extends StatelessWidget {
  const MedicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicationsDataCubit(getIt()),
      child: const MedicationViewBody(),
    );
  }
}
