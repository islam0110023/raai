part of 'caregiver_list_cubit.dart';

@immutable
sealed class CaregiverListState {}

final class CaregiverListInitial extends CaregiverListState {}

final class CaregiverListLoading extends CaregiverListState {}

final class CaregiverListNoData extends CaregiverListState {}

final class CaregiverListSuccess extends CaregiverListState {
  CaregiverListSuccess(this.data);

  final List<CaregiverListEntity> data;
}

final class CaregiverListFailure extends CaregiverListState {
  CaregiverListFailure(this.message, this.code);
  final String message;
  final int? code;
}
