import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/models/domain/entity/sugar_monthly_entity.dart';
import 'package:raai/feature/models/domain/use_case/get_sugar_monthly_use_case.dart';

part 'sugar_monthly_state.dart';

class SugarMonthlyCubit extends Cubit<SugarMonthlyState> {
  SugarMonthlyCubit(this.getSugarMonthlyUseCase)
    : super(SugarMonthlyInitial()) {
    getSugarMonthly();
  }
  final GetSugarMonthlyUseCase getSugarMonthlyUseCase;
  void getSugarMonthly() async {
    emit(SugarMonthlyLoading());
    final data = await getSugarMonthlyUseCase();
    data.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);

        emit(SugarMonthlyFailure(message, failure.appCode));
      },
      (data) {
        Future.delayed(const Duration(seconds: 3),() {
          emit(SugarMonthlySuccess(data));
        },);
      },
    );
  }
}
