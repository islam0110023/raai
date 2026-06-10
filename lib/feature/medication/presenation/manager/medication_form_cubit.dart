import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';

class MedicationFormCubit extends Cubit<InputMedicationModel> {
  MedicationFormCubit() : super(InputMedicationModel(dosesPerDay: 1));

  void updateName(String value) {
    emit(state.copyWith(name: value));
  }

  void updateCategory(String value) {
    emit(state.copyWith(category: value));
  }

  // void updateDosesPerDay(String value) {
  //   emit(state.copyWith(dosesPerDay: value));
  // }

  void updateImage(String? path) async {
    final compressed = await FlutterImageCompress.compressAndGetFile(
      path!,
      '${path}_compressed.jpg',
      quality: 50,
    );
    if (compressed == null) {
      return;
    }
    emit(state.copyWith(image: compressed.path));
  }

  void updateForm(String value) {
    emit(state.copyWith(form: value));
  }

  void updatePillsPerDose(String value) {
    emit(state.copyWith(pillsPerDose: value));
  }

  void incrementDoses() {
    emit(state.copyWith(dosesPerDay: (state.dosesPerDay! + 1)));
  }

  void decrementDoses() {
    if (state.dosesPerDay! > 1) {
      emit(state.copyWith(dosesPerDay: (state.dosesPerDay! - 1)));
    }
  }

  void updateStartTime(String value) {
    emit(state.copyWith(startTime: value));
  }

  void updateTotalPills(String value) {
    emit(state.copyWith(totalPills: value));
  }

  void updateWithFood(bool value) {
    emit(state.copyWith(withFood: value));
  }

  void updateFoodTiming(String? value) {
    emit(state.copyWith(foodTiming: value));
  }

  void updateRepeatType(String value) {
    emit(state.copyWith(repeatType: value));
  }
}
