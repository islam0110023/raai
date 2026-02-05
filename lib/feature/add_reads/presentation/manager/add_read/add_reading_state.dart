part of 'add_reading_cubit.dart';

@immutable
sealed class AddReadingState {}

final class AddReadingInitial extends AddReadingState {}

final class AddReadingSugarLoading extends AddReadingState {}

final class AddReadingSugarSuccess extends AddReadingState {}

final class AddReadingSugarIsEmpty extends AddReadingState {}

final class AddReadingSugarFailure extends AddReadingState {
  AddReadingSugarFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}

final class AddReadingBloodLoading extends AddReadingState {}

final class AddReadingBloodSuccess extends AddReadingState {}

final class AddReadingBloodIsEmpty extends AddReadingState {}

final class AddReadingBloodFailure extends AddReadingState {
  AddReadingBloodFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}
