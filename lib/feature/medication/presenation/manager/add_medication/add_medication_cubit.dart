import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/domain/use_case/create_medication_use_case.dart';

part 'add_medication_state.dart';

class AddMedicationCubit extends Cubit<AddMedicationState> {
  AddMedicationCubit(this.createMedicationUseCase)
    : super(AddMedicationInitial());
  final CreateMedicationUseCase createMedicationUseCase;
  Future<void> createMedication(
    InputMedicationModel inputMedicationModel,
  ) async {
    emit(AddMedicationLoading());
    final result = await createMedicationUseCase(inputMedicationModel);
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);

        emit(AddMedicationFailure(message, failure.appCode));
      },
      (success) {
        emit(AddMedicationSuccess());
      },
    );
  }
}
