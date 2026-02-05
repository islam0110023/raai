import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/personal_info/domain/use_case/set_personal_info_use_case.dart';

part 'personal_state.dart';

class PersonalCubit extends Cubit<PersonalState> {
  PersonalCubit(this.setPersonalInfoUseCase) : super(PersonalInitial()) {
    init();
  }
  final SetPersonalInfoUseCase setPersonalInfoUseCase;
  late TextEditingController birthDate;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late GlobalKey<FormState> formKey;
  bool? gender;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  void init() {
    birthDate = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  void changeGender(bool value) {
    gender = value;
    emit(PersonalInitial());
  }

  void setPersonalInfo() async {
    if (formKey.currentState!.validate() && gender != null) {
      autoValidateMode = AutovalidateMode.disabled;
      formKey.currentState!.save();
      emit(PersonalLoading());
      final result = await setPersonalInfoUseCase.call(
        gender: gender! ? 'MALE' : 'FEMALE',
        birthDate: birthDate.text,
        firstName: firstName.text,
        lastName: lastName.text,
      );
      result.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);
          emit(PersonalFailure(message, failure.appCode));
        },
        (success) {
          emit(PersonalSuccess());
        },
      );
    } else {
      autoValidateMode = AutovalidateMode.always;
      emit(PersonalInitial());
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    birthDate.dispose();
    firstName.dispose();
    lastName.dispose();
    return super.close();
  }
}
