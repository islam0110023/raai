import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/medication/domain/use_case/snooze_medication_use_case.dart';
import 'package:raai/feature/medication/domain/use_case/take_medication_use_case.dart';

part 'medication_reminder_state.dart';

class MedicationReminderCubit extends Cubit<MedicationReminderState> {
  MedicationReminderCubit(
    this.takeMedicationUseCase,
    this.snoozeMedicationUseCase,
  ) : super(MedicationReminderInitial());
  final TakeMedicationUseCase takeMedicationUseCase;
  final SnoozeMedicationUseCase snoozeMedicationUseCase;
  void takeMedication(int doseId) async {
    emit(MedicationReminderLoading());
    final result = await takeMedicationUseCase(doseId);
    result.fold((l) {
      final message = ApiErrorMapper.getArabicMessage(l.appCode);
      emit(MedicationReminderFailure(message, l.appCode));
    }, (r) => emit(MedicationReminderSuccess()));
  }

  void snoozeMedication(int doseId) async {
    emit(MedicationReminderLoading());
    final result = await snoozeMedicationUseCase(doseId);
    result.fold((l) {
      final message = ApiErrorMapper.getArabicMessage(l.appCode);
      emit(MedicationReminderFailure(message, l.appCode));
    }, (r) => emit(MedicationReminderSnoozeSuccess()));
  }
}
