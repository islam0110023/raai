import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/caregivers/domain/entity/caregiver_list_entity.dart';
import 'package:raai/feature/caregivers/domain/use_case/get_caregiver_list_use_case.dart';

part 'caregiver_list_state.dart';

class CaregiverListCubit extends Cubit<CaregiverListState> {
  CaregiverListCubit(this.getCaregiverListUseCase)
    : super(CaregiverListInitial()) {
    getCaregiverList();
  }
  final GetCaregiverListUseCase getCaregiverListUseCase;
  Future<void> getCaregiverList() async {
    emit(CaregiverListLoading());
    final result = await getCaregiverListUseCase();
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);
        emit(CaregiverListFailure(message, failure.appCode));
      },
      (r) {
        if (r.isEmpty) {
          emit(CaregiverListNoData());
        } else {
          emit(CaregiverListSuccess(r));
        }
      },
    );
  }
}
