import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_reads_state.dart';

class AddReadsCubit extends Cubit<AddReadsState> {
  AddReadsCubit(bool initialIsBlood)
    : super(AddReadsState(isBlood: initialIsBlood));
  void changeIsBlood(bool value) {
    emit(AddReadsInitial(isBlood: value));
  }
}
