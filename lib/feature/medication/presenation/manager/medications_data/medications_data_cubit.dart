import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';
import 'package:raai/feature/medication/domain/use_case/get_medications_use_case.dart';

part 'medications_data_state.dart';

class MedicationsDataCubit extends Cubit<MedicationsDataState> {
  MedicationsDataCubit(this.getMedicationsUseCase)
    : super(MedicationsDataInitial()) {
    getMedications();
  }
  final GetMedicationsUseCase getMedicationsUseCase;
  Future<void> getMedications() async {
    emit(MedicationsDataLoading());
    final result = await getMedicationsUseCase.call();
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);

        emit(MedicationsDataFailure(message, failure.appCode));
      },
      (data) => emit(
        data.isEmpty ? MedicationsDataNoData() : MedicationsDataSuccess(data),
      ),
    );
  }
}
