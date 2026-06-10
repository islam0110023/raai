import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/home/domain/entities/home_data_entity.dart';
import 'package:raai/feature/home/domain/use_case/get_home_data_use_case.dart';

part 'home_data_state.dart';

class HomeDataCubit extends Cubit<HomeDataState> {
  HomeDataCubit(this.getHomeDataUseCase) : super(HomeDataInitial()) {
    getHomeData();
  }
  final GetHomeDataUseCase getHomeDataUseCase;

  Future<void> getHomeData() async {
    emit(HomeDataLoading());
    final result = await getHomeDataUseCase();
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);
        emit(HomeDataFailure(message, failure.appCode));
      },
      (data) {
        emit(HomeDataSuccess(data));
      },
    );
  }
}
