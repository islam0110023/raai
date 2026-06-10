import 'package:raai/feature/home/data/model/home_data_model/blood_pressure.dart';
import 'package:raai/feature/home/data/model/home_data_model/sugar.dart';

class LastReadings {

  LastReadings({this.bloodPressure, this.sugar});

  factory LastReadings.fromJson(Map<String, dynamic> json) => LastReadings(
    bloodPressure: json['bloodPressure'] == null
        ? null
        : BloodPressure.fromJson(json['bloodPressure'] as Map<String, dynamic>),
    sugar: json['sugar'] == null
        ? null
        : Sugar.fromJson(json['sugar'] as Map<String, dynamic>),
  );
  BloodPressure? bloodPressure;
  Sugar? sugar;

  Map<String, dynamic> toJson() => {
    'bloodPressure': bloodPressure?.toJson(),
    'sugar': sugar?.toJson(),
  };
}
