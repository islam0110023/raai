import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/reads/domain/entity/blood_read_entity.dart';
import 'package:raai/feature/reads/domain/use_case/get_blood_reads_use_case.dart';
import 'package:raai/feature/reads/domain/use_case/update_blood_use_case.dart';

part 'blood_state.dart';

class BloodCubit extends Cubit<BloodState> {
  BloodCubit(this.getBloodReadsUseCase, this.updateBloodUseCase)
    : super(BloodInitial()) {
    getBloodReads();
    init();
  }
  final GetBloodReadsUseCase getBloodReadsUseCase;
  final UpdateBloodUseCase updateBloodUseCase;
  late TextEditingController systolicController;
  late TextEditingController diastolicController;

  void init() {
    systolicController = TextEditingController();
    diastolicController = TextEditingController();
  }

  DateTime? recordedAt;

  void getBloodReads() async {
    emit(ReadBloodLoading());
    final data = await getBloodReadsUseCase();
    data.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);
        emit(ReadBloodFailure(message, failure.appCode));
      },
      (data) {
        if (data.isEmpty) {
          emit(ReadBloodNoData());
        } else {
          recordedAt = data[0].recordedAtDate;
          emit(ReadBloodSuccess(data));
        }
      },
    );
  }

  void updateBlood({required String id}) async {
    if (systolicController.text.isNotEmpty &&
        diastolicController.text.isNotEmpty) {
      emit(BloodLoading());
      final data = await updateBloodUseCase(
        id: id,
        systolic: systolicController.text,
        diastolic: diastolicController.text,
      );
      data.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);
          emit(BloodFailure(message, failure.appCode));
        },
        (data) {
          systolicController.clear();
          diastolicController.clear();
          emit(BloodSuccess());
        },
      );
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    systolicController.dispose();
    diastolicController.dispose();
    return super.close();
  }
}
