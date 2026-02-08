import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/profile/presentation/manager/profile/profile_cubit.dart';
import 'package:raai/feature/profile/presentation/view/widget/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ProfileCubit(getIt()),
      child: const ProfileViewBody(),
    );
  }
}
