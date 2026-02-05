part of 'read_cubit.dart';

@immutable
sealed class ReadState {}

final class ReadInitial extends ReadState {}

final class ReadSugarLoading extends ReadState {}

final class ReadSugarNoData extends ReadState {}

final class ReadSugarSuccess extends ReadState {
  ReadSugarSuccess(this.data);
  final List<SugarReadEntity> data;
}

final class ReadSugarFailure extends ReadState {
  ReadSugarFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}

final class ReadLoading extends ReadState {}

final class ReadSuccess extends ReadState {}

final class ReadFailure extends ReadState {
  ReadFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}
