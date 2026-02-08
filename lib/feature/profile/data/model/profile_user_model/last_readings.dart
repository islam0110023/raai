import 'package:raai/feature/profile/data/model/profile_user_model/blood_pressure.dart';
import 'package:raai/feature/profile/data/model/profile_user_model/sugar.dart';

class LastReadings {

  factory LastReadings.fromJson(Map<String, dynamic> json) => LastReadings(
    sugar: json['sugar'] == null
        ? null
        : Sugar.fromJson(json['sugar'] as Map<String, dynamic>),
    bloodPressure: json['bloodPressure'] == null
        ? null
        : BloodPressure.fromJson(json['bloodPressure'] as Map<String, dynamic>),
  );

  LastReadings({this.sugar, this.bloodPressure});
  Sugar? sugar;
  BloodPressure? bloodPressure;

  Map<String, dynamic> toJson() => {
    'sugar': sugar?.toJson(),
    'bloodPressure': bloodPressure?.toJson(),
  };
}
