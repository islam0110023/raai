import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/auth/domain/entity/reset_entity.dart';
import 'package:raai/feature/auth/domain/use_case/reset_pass_use_case.dart';

part 'reset_state.dart';

class ResetCubit extends Cubit<ResetState> {
  ResetCubit(this.resetPassUseCase) : super(ResetInitial());
  final ResetPassUseCase resetPassUseCase;
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  void resetPass() async {
    if (formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.disabled;
      formKey.currentState!.save();
      emit(ResetLoading());
      final result = await resetPassUseCase.call(email: emailController.text);

      result.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);

          emit(ResetFailure(message, failure.appCode));
        },
        (entity) {
          emit(ResetSuccess(entity));
        },
      );
    } else {
      autoValidateMode = AutovalidateMode.always;
      emit(ResetInitial());
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    emailController.dispose();
    return super.close();
  }
}
