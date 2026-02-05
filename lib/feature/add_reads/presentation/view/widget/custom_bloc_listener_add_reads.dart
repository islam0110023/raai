import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/add_reads/presentation/manager/add_read/add_reading_cubit.dart';

class CustomBlocListenerAddReads extends StatelessWidget {
  const CustomBlocListenerAddReads({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddReadingCubit, AddReadingState>(
      listener: (context, state) {
        if (state is AddReadingSugarSuccess) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          showAnimatedTopSnackBar(
            context,
            message: 'نجحت',
            subMessage: 'تم تسجيل قيمة السكر بنجاح',
          );
        }
        if (state is AddReadingSugarFailure) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          showAnimatedTopSnackBar(
            context,
            isError: true,
            message: 'في مشكلة',
            subMessage: state.message,
          );
        }
        if (state is AddReadingSugarIsEmpty) {
          showAnimatedTopSnackBar(
            context,
            isError: true,
            message: 'في مشكلة',
            subMessage: 'ادخل قيمة السكر',
          );
        }
        if (state is AddReadingSugarLoading) {
          AppConstant.showLoadingDialog(context);
        }
        if (state is AddReadingBloodSuccess) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          showAnimatedTopSnackBar(
            context,
            message: 'نجحت',
            subMessage: 'تم تسجيل قيم الضغط بنجاح',
          );
        }
        if (state is AddReadingBloodFailure) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          showAnimatedTopSnackBar(
            context,
            isError: true,
            message: 'في مشكلة',
            subMessage: state.message,
          );
        }
        if (state is AddReadingBloodIsEmpty) {
          showAnimatedTopSnackBar(
            context,
            isError: true,
            message: 'في مشكلة',
            subMessage: 'ادخل قيم الضغط',
          );
        }
        if (state is AddReadingBloodLoading) {
          AppConstant.showLoadingDialog(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
