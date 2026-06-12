part of 'connect_elder_caregiver_cubit.dart';

@immutable
sealed class ConnectElderCaregiverState {}

final class ConnectElderCaregiverInitial extends ConnectElderCaregiverState {}

class ConnectElderCaregiverScanned extends ConnectElderCaregiverState {
  ConnectElderCaregiverScanned({required this.elderId});
  final String elderId;
}

class ConnectElderCaregiverLoading extends ConnectElderCaregiverState {}

class ConnectElderCaregiverSuccess extends ConnectElderCaregiverState {}

class ConnectElderCaregiverFailure extends ConnectElderCaregiverState {
  ConnectElderCaregiverFailure(this.message);
  final String message;
}
