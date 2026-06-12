import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_data_entity.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/use_case/get_home_caregiver_data_use_case.dart';

part 'home_caregiver_state.dart';

class HomeCaregiverCubit extends Cubit<HomeCaregiverState> {
  HomeCaregiverCubit(this.getHomeCaregiverDataUseCase)
    : super(HomeCaregiverInitial()) {
    getHomeCaregiverData();
  }
  final GetHomeCaregiverDataUseCase getHomeCaregiverDataUseCase;
  Future<void> getHomeCaregiverData() async {
    emit(HomeCaregiverLoading());
    final result = await getHomeCaregiverDataUseCase();
    result.fold((failure) {
      final message = ApiErrorMapper.getArabicMessage(failure.appCode);
      emit(HomeCaregiverFailure(message, failure.appCode));
    }, (data) => emit(HomeCaregiverSuccess(data)));
  }
}
