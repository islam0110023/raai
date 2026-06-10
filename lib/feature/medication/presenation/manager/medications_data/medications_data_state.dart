part of 'medications_data_cubit.dart';

@immutable
sealed class MedicationsDataState {}

final class MedicationsDataInitial extends MedicationsDataState {}

final class MedicationsDataLoading extends MedicationsDataState {}

final class MedicationsDataSuccess extends MedicationsDataState {
  MedicationsDataSuccess(this.data);
  final List<MedicationDataEntity> data;
}

final class MedicationsDataNoData extends MedicationsDataState {}

final class MedicationsDataFailure extends MedicationsDataState {
  MedicationsDataFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}
