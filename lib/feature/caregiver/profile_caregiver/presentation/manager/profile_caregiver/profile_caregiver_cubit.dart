import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/entity/profile_caregiver_data_entity.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/use_case/get_profile_caregiver_data_use_case.dart';

part 'profile_caregiver_state.dart';

class ProfileCaregiverCubit extends Cubit<ProfileCaregiverState> {
  ProfileCaregiverCubit(this.getProfileCaregiverDataUseCase)
    : super(ProfileCaregiverInitial()) {
    getProfileCaregiverData();
  }
  final GetProfileCaregiverDataUseCase getProfileCaregiverDataUseCase;
  Future<void> getProfileCaregiverData() async {
    emit(ProfileCaregiverLoading());
    final result = await getProfileCaregiverDataUseCase();
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);
        emit(ProfileCaregiverFailure(message, failure.appCode));
      },
      (data) {
        emit(ProfileCaregiverSuccess(data));
      },
    );
  }
}
