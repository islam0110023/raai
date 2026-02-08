import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/widget/error_view.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/models/presentation/manager/sugar_daily/sugar_daily_cubit.dart';
import 'package:raai/feature/models/presentation/view/wadget/custom_success_sugar_daily_model.dart';
import 'package:raai/feature/models/presentation/view/wadget/loading_model_view.dart';

class SugarDailyModelScreenBody extends StatelessWidget {
  const SugarDailyModelScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SugarDailyCubit, SugarDailyState>(
      builder: (context, state) {
        if (state is SugarDailySuccess) {
          return CustomSuccessSugarDailyModel(state: state);
        }
        if (state is SugarDailyLoading) {
          return const LoadingModelView();
        }
        if (state is SugarDailyFailure) {
          return ErrorView(
            isExpanded: true,
            onPressed: () {
              context.read<SugarDailyCubit>().getSugarDaily();
            },
          );
        }
        return const SizedBox();
      },
      listener: (context, state) {
        if (state is SugarDailyFailure) {
          showAnimatedTopSnackBar(
            context,
            isError: true,
            message: 'في مشكلة',
            subMessage: state.message,
          );
        }
      },
    );
  }
}
