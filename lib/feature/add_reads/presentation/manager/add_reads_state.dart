part of 'add_reads_cubit.dart';

@immutable
class AddReadsState {
  const AddReadsState({required this.isBlood});
  final bool isBlood;
}

final class AddReadsInitial extends AddReadsState {
  const AddReadsInitial({required super.isBlood});
}
