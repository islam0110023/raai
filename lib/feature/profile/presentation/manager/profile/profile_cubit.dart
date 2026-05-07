import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/profile/domain/entity/profile_user_entity.dart';
import 'package:raai/feature/profile/domain/use_case/get_user_profile_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.getUserProfileUseCase) : super(ProfileInitial()) {
    // getUserProfile();
  }
  final GetUserProfileUseCase getUserProfileUseCase;
  ProfileUserEntity? profileUserEntity;

  void getUserProfile() async {
    emit(ProfileLoading());
    final result = await getUserProfileUseCase();
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);
        emit(ProfileFailure(message, failure.appCode));
      },
      (data) {
        profileUserEntity = data;
        emit(ProfileSuccess(data));
      },
    );
  }
}
