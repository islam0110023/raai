import 'package:dio/dio.dart';

class InputMedicationModel {
  InputMedicationModel({
    this.category,
    this.dosesPerDay,
    this.foodTiming,
    this.form,
    this.image,
    this.name,
    this.pillsPerDose,
    this.repeatType,
    this.startTime,
    this.totalPills,
    this.withFood,
  });

  String? category;
  int? dosesPerDay;
  String? foodTiming;
  String? form;
  String? image; // image path
  String? name;
  String? pillsPerDose;
  String? repeatType;
  String? startTime;
  String? totalPills;
  bool? withFood;
  InputMedicationModel copyWith({
    String? category,
    int? dosesPerDay,
    String? foodTiming,
    String? form,
    String? image,
    String? name,
    String? pillsPerDose,
    String? repeatType,
    String? startTime,
    String? totalPills,
    bool? withFood,
  }) {
    return InputMedicationModel(
      category: category ?? this.category,
      dosesPerDay: dosesPerDay ?? this.dosesPerDay,
      foodTiming: foodTiming ?? this.foodTiming,
      form: form ?? this.form,
      image: image ?? this.image,
      name: name ?? this.name,
      pillsPerDose: pillsPerDose ?? this.pillsPerDose,
      repeatType: repeatType ?? this.repeatType,
      startTime: startTime ?? this.startTime,
      totalPills: totalPills ?? this.totalPills,
      withFood: withFood ?? this.withFood,
    );
  }

  String? get validationMessage {
    if (image?.isEmpty ?? true) {
      return 'يرجى اختيار صورة الدواء';
    }

    if (name?.isEmpty ?? true) {
      return 'يرجى إدخال اسم الدواء';
    }

    if (category?.isEmpty ?? true) {
      return 'يرجى اختيار فئة الدواء';
    }

    if (form?.isEmpty ?? true) {
      return 'يرجى اختيار نوع الدواء';
    }

    if (repeatType?.isEmpty ?? true) {
      return 'يرجى تحديد معدل التكرار';
    }

    if (dosesPerDay == null || dosesPerDay! <= 0) {
      return 'يرجى تحديد عدد الجرعات';
    }
    if (startTime?.isEmpty ?? true) {
      return 'يرجى تحديد موعد البداية';
    }

    if (withFood == null) {
      return 'يرجى تحديد ما إذا كان الدواء يؤخذ مع الطعام';
    }

    if (withFood == true && (foodTiming?.isEmpty ?? true)) {
      return 'يرجى تحديد هل يؤخذ قبل الطعام أم بعده';
    }

    if (pillsPerDose?.isEmpty ?? true) {
      return 'يرجى تحديد عدد الحبات في الجرعة';
    }

    if (totalPills?.isEmpty ?? true) {
      return 'يرجى تحديد إجمالي عدد الحبات';
    }

    return null;
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'category': category,
      'dosesPerDay': dosesPerDay,
      'foodTiming': foodTiming,
      'form': form,
      'name': name,
      'pillsPerDose': pillsPerDose,
      'repeatType': repeatType,
      'startTime': startTime,
      'totalPills': totalPills,
      'withFood': withFood,
      if (image != null)
        'image': await MultipartFile.fromFile(
          image!,
          filename: image!.split('/').last,
        ),
    });
  }
}
