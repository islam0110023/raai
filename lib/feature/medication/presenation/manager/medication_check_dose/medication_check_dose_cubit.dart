import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/medication/domain/entities/do_not_remember_entity.dart';
import 'package:raai/feature/medication/domain/entities/tablet_model_entity.dart';
import 'package:raai/feature/medication/domain/use_case/do_not_remember_use_case.dart';
import 'package:raai/feature/medication/domain/use_case/tablet_model_use_case.dart';

part 'medication_check_dose_state.dart';

class MedicationCheckDoseCubit extends Cubit<MedicationCheckDoseState> {
  MedicationCheckDoseCubit(this.doNotRememberUseCase, this.tabletModelUseCase)
    : super(MedicationCheckDoseInitial());
  String? image;
  final DoNotRememberUseCase doNotRememberUseCase;
  final TabletModelUseCase tabletModelUseCase;
  final elderCodeController = TextEditingController();
  void updateImage(String? path) async {
    final compressed = await FlutterImageCompress.compressAndGetFile(
      path!,
      '${path}_compressed.jpg',
      quality: 50,
    );
    if (compressed == null) {
      return;
    }
    image = compressed.path;
    emit(MedicationCheckDoseInitial());
  }

  Future<void> tabletModel(String? image) async {
    if (image == null) {
      return;
    }
    emit(MedicationCheckDoseLoading());
    final result = await tabletModelUseCase(image);
    result.fold(
      (failure) {
        emit(MedicationCheckDoseFailure(failure.message, 0));
      },
      (success) {
        emit(MedicationCheckDoseModelSuccess(success));
      },
    );
  }

  Future<void> doNotRemember(int medicationId, int actualRemainingPills) async {
    if (elderCodeController.text.isNotEmpty) {
      emit(MedicationCheckDoseLoading());
    }
    final result = await doNotRememberUseCase(
      medicationId,
      actualRemainingPills,
    );
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);
        emit(MedicationCheckDoseFailure(message, failure.appCode));
      },
      (success) {
        emit(MedicationCheckDoseRememberSuccess(success));
      },
    );
  }
}
