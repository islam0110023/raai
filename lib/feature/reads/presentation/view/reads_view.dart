import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/reads/presentation/manager/blood/blood_cubit.dart'
    show BloodCubit;
import 'package:raai/feature/reads/presentation/manager/read/read_cubit.dart';
import 'package:raai/feature/reads/presentation/view/widget/reads_view_body.dart';

class ReadsView extends StatelessWidget {
  const ReadsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BloodCubit(getIt(), getIt())),
        BlocProvider(create: (context) => ReadCubit(getIt(), getIt())),
      ],
      child: const ReadsViewBody(),
    );
  }
}
