part of 'home_data_cubit.dart';

@immutable
sealed class HomeDataState {}

final class HomeDataInitial extends HomeDataState {}

final class HomeDataLoading extends HomeDataState {}

final class HomeDataSuccess extends HomeDataState {
  HomeDataSuccess(this.homeData);

  final HomeDataEntity homeData;
}

final class HomeDataFailure extends HomeDataState {
  HomeDataFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}
