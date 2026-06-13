import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_medication_in_caregiver_entity.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/use_case/get_all_medication_in_caregiver_use_case.dart';

part 'all_medication_caregiver_state.dart';

class AllMedicationCaregiverCubit extends Cubit<AllMedicationCaregiverState> {
  AllMedicationCaregiverCubit(this.getAllMedicationInCaregiverUseCase)
    : super(AllMedicationCaregiverInitial()) {
    getAllMedicationInCaregiver();
  }
  final GetAllMedicationInCaregiverUseCase getAllMedicationInCaregiverUseCase;
  AllMedicationInCaregiverEntity? _originalData;

  Future<void> getAllMedicationInCaregiver() async {
    emit(AllMedicationCaregiverLoading());
    final result = await getAllMedicationInCaregiverUseCase();
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);
        emit(AllMedicationCaregiverFailure(message, failure.appCode));
      },
      (r) {
        _originalData = r;
        emit(AllMedicationCaregiverSuccess(r));
      },
    );
  }

  void filterByElder(int elderId) {
    if (_originalData == null) return;

    final filteredDoses = _originalData!.doses
        .where((dose) => dose.elderId == elderId)
        .toList();

    emit(
      AllMedicationCaregiverSuccess(
        AllMedicationInCaregiverEntity(
          taken: _originalData!.taken,
          missed: _originalData!.missed,
          upcoming: _originalData!.upcoming,
          snoozed: _originalData!.snoozed,
          elders: _originalData!.elders,
          doses: filteredDoses,
        ),
      ),
    );
  }

  void clearFilter() {
    if (_originalData == null) return;

    emit(AllMedicationCaregiverSuccess(_originalData!));
  }
}
