import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/domain/use_case/connect_caregiver_with_elder_use_case.dart';

part 'connect_elder_caregiver_state.dart';

class ConnectElderCaregiverCubit extends Cubit<ConnectElderCaregiverState> {
  ConnectElderCaregiverCubit(this.connectCaregiverWithElderUseCase)
    : super(ConnectElderCaregiverInitial());
  final ConnectCaregiverWithElderUseCase connectCaregiverWithElderUseCase;

  final elderCodeController = TextEditingController();
  final MobileScannerController mobileScannerController =
      MobileScannerController();
  bool isScanned = false;
  bool isScanning = false;

  void startScanning() {
    isScanning = true;
    emit(ConnectElderCaregiverInitial());
  }

  Future<void> onQrScanned(String code) async {
    elderCodeController.text = code;
    await mobileScannerController.stop();

    isScanned = false;
    isScanning = false;
    emit(ConnectElderCaregiverScanned(elderId: code));
    emit(ConnectElderCaregiverInitial());
  }

  Future<void> connectCaregiverWithElder() async {
    emit(ConnectElderCaregiverLoading());
    elderCodeController.text = elderCodeController.text.trim();
    if (elderCodeController.text.isEmpty) {
      emit(ConnectElderCaregiverFailure('كود المسن مطلوب'));
      return;
    }
    final result = await connectCaregiverWithElderUseCase(
      elderCodeController.text,
    );
    result.fold((l) {
      final message = ApiErrorMapper.getArabicMessage(l.appCode);
      emit(ConnectElderCaregiverFailure(message));
    }, (r) => emit(ConnectElderCaregiverSuccess()));
  }

  @override
  Future<void> close() {
    elderCodeController.dispose();
    mobileScannerController.dispose();
    return super.close();
  }
}
