import 'package:raai/core/utils/constants.dart';
import 'package:raai/feature/profile/domain/entity/personal_data_entity.dart';

class PersonalData {
  PersonalData({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.gender,
    this.userId,
    this.createdAt,
  });

  factory PersonalData.fromJson(Map<String, dynamic> json) => PersonalData(
    id: json['id'] as int?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    gender: json['gender'] as String?,
    userId: json['userId'] as int?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
  int? id;
  String? firstName;
  String? lastName;
  DateTime? birthDate;
  String? gender;
  int? userId;
  DateTime? createdAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'birthDate': birthDate?.toIso8601String(),
    'gender': gender,
    'userId': userId,
    'createdAt': createdAt?.toIso8601String(),
  };
  PersonalDataEntity toEntity() {
    return PersonalDataEntity(
      id: id!,
      firstName: firstName!,
      lastName: lastName!,
      fullName: '$firstName $lastName',
      birthDate: birthDate!,
      gender: gender!,
      userId: userId!,
      age: AppConstant.calculateAge(birthDate.toString()),
    );
  }
}
