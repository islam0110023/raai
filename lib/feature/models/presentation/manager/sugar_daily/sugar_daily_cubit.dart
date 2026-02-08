import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/models/domain/entity/sugar_daily_entity.dart';
import 'package:raai/feature/models/domain/use_case/get_sugar_daily_use_case.dart';

part 'sugar_daily_state.dart';

class SugarDailyCubit extends Cubit<SugarDailyState> {
  SugarDailyCubit(this.getSugarDailyUseCase) : super(SugarDailyInitial()) {
    getSugarDaily();
  }
  final GetSugarDailyUseCase getSugarDailyUseCase;
  void getSugarDaily() async {
    emit(SugarDailyLoading());
    final data = await getSugarDailyUseCase();
    data.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);

        emit(SugarDailyFailure(message, failure.appCode));
      },
      (data) {
         Future.delayed(const Duration(seconds: 3),() {
           emit(SugarDailySuccess(data));
         },);
      },
    );
  }
}
