import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/auth/domain/entity/select_role_entity.dart';
import 'package:raai/feature/auth/domain/use_case/select_role_use_case.dart';

part 'select_role_state.dart';

class SelectRoleCubit extends Cubit<SelectRoleState> {
  SelectRoleCubit(this.selectRoleUseCase) : super(SelectRoleInitial());
  final SelectRoleUseCase selectRoleUseCase;
  bool isRole = true;
  void selectIsRole(bool role) {
    isRole = role;
    emit(SelectRoleInitial());
  }

  void selectRole() async {
    emit(SelectRoleLoading());
    final result = await selectRoleUseCase.call(
      role: isRole ? 'ELDER' : 'CAREGIVER',
    );
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);

        emit(SelectRoleFailure(message, failure.appCode));
      },
      (entity) {
        emit(SelectRoleSuccess(entity));
      },
    );
  }
}
