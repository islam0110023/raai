import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/home/presentation/manager/home_data/home_data_cubit.dart';
import 'package:raai/feature/home/presentation/view/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeDataCubit(getIt()),
      child: const HomeViewBody(),
    );
  }
}
