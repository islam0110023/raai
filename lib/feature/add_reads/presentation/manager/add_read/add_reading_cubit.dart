import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/add_reads/domain/use_case/add_blood_use_case.dart';
import 'package:raai/feature/add_reads/domain/use_case/add_sugar_use_case.dart';

part 'add_reading_state.dart';

class AddReadingCubit extends Cubit<AddReadingState> {
  AddReadingCubit(this.addSugarUseCase, this.addBloodUseCase)
    : super(AddReadingInitial()) {
    init();
  }
  final AddSugarUseCase addSugarUseCase;
  final AddBloodUseCase addBloodUseCase;

  late TextEditingController sugarController;
  late TextEditingController systolicController;
  late TextEditingController diastolicController;

  void init() {
    sugarController = TextEditingController();
    systolicController = TextEditingController();
    diastolicController = TextEditingController();
  }

  void addSugar() async {
    if (sugarController.text.isNotEmpty) {
      emit(AddReadingSugarLoading());
      final result = await addSugarUseCase.call(sugar: sugarController.text);
      result.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);
          emit(AddReadingSugarFailure(message, failure.appCode));
        },
        (success) {
          sugarController.clear();
          emit(AddReadingSugarSuccess());
        },
      );
    } else {
      emit(AddReadingSugarIsEmpty());
    }
  }

  void addBlood() async {
    if (systolicController.text.isNotEmpty &&
        diastolicController.text.isNotEmpty) {
      emit(AddReadingBloodLoading());
      final result = await addBloodUseCase.call(
        systolic: systolicController.text,
        diastolic: diastolicController.text,
      );
      result.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);
          emit(AddReadingBloodFailure(message, failure.appCode));
        },
        (success) {
          systolicController.clear();
          diastolicController.clear();
          emit(AddReadingBloodSuccess());
        },
      );
    } else {
      emit(AddReadingBloodIsEmpty());
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    sugarController.dispose();
    systolicController.dispose();
    diastolicController.dispose();
    return super.close();
  }
}
