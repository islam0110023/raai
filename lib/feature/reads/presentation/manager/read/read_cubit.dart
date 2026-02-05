import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/reads/domain/entity/sugar_read_entity.dart';
import 'package:raai/feature/reads/domain/use_case/get_sugar_reads_use_case.dart';
import 'package:raai/feature/reads/domain/use_case/update_sugar_use_case.dart';

part 'read_state.dart';

class ReadCubit extends Cubit<ReadState> {
  ReadCubit(this.getSugarReadsUseCase, this.updateSugarUseCase)
    : super(ReadInitial()) {
    getSugarReads();
    init();
  }
  final GetSugarReadsUseCase getSugarReadsUseCase;
  final UpdateSugarUseCase updateSugarUseCase;
  late TextEditingController sugarController;

  void init() {
    sugarController = TextEditingController();
  }

  void getSugarReads() async {
    emit(ReadSugarLoading());
    final data = await getSugarReadsUseCase();
    data.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);
        emit(ReadSugarFailure(message, failure.appCode));
      },
      (data) {
        if (data.isEmpty) {
          emit(ReadSugarNoData());
        } else {
          emit(ReadSugarSuccess(data));
        }
      },
    );
  }

  void updateSugar({required String id}) async {
    if (sugarController.text.isNotEmpty) {
      emit(ReadLoading());
      final data = await updateSugarUseCase(
        id: id,
        value: sugarController.text,
      );
      data.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);
          emit(ReadFailure(message, failure.appCode));
        },
        (data) {
          sugarController.clear();
          emit(ReadSuccess());
        },
      );
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    sugarController.dispose();
    return super.close();
  }
}
