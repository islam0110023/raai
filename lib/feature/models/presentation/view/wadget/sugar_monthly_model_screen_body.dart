import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/widget/error_view.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/models/presentation/manager/sugar_monthly/sugar_monthly_cubit.dart';
import 'package:raai/feature/models/presentation/view/wadget/custom_success_return_sugar_model.dart';
import 'package:raai/feature/models/presentation/view/wadget/loading_model_view.dart';

class SugarMonthlyModelScreenBody extends StatelessWidget {
  const SugarMonthlyModelScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SugarMonthlyCubit, SugarMonthlyState>(
      listener: (context, state) {
        if (state is SugarMonthlyFailure) {
          showAnimatedTopSnackBar(
            context,
            isError: true,
            message: 'في مشكلة',
            subMessage: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is SugarMonthlySuccess) {
          return CustomSuccessReturnSugarModel(state: state);
        }
        if (state is SugarMonthlyLoading) {
          return const LoadingModelView();
        }
        if (state is SugarMonthlyFailure) {
          return ErrorView(
            isExpanded: true,
            onPressed: () {
              context.read<SugarMonthlyCubit>().getSugarMonthly();
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
