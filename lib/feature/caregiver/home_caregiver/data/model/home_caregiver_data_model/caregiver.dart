import 'package:raai/feature/caregiver/home_caregiver/data/model/home_caregiver_data_model/personal_data.dart';

class Caregiver {
  Caregiver({
    this.id,
    this.keycloakId,
    this.fullName,
    this.email,
    this.phone,
    this.role,
    this.createdAt,
    this.personalData,
    this.healthProfile,
  });

  factory Caregiver.fromJson(Map<String, dynamic> json) => Caregiver(
    id: json['id'] as int?,
    keycloakId: json['keycloakId'] as String?,
    fullName: json['fullName'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    role: json['role'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    personalData: json['personalData'] == null
        ? null
        : PersonalData.fromJson(json['personalData'] as Map<String, dynamic>),
    healthProfile: json['healthProfile'] as dynamic,
  );
  int? id;
  String? keycloakId;
  String? fullName;
  String? email;
  String? phone;
  String? role;
  DateTime? createdAt;
  PersonalData? personalData;
  dynamic healthProfile;

  Map<String, dynamic> toJson() => {
    'id': id,
    'keycloakId': keycloakId,
    'fullName': fullName,
    'email': email,
    'phone': phone,
    'role': role,
    'createdAt': createdAt?.toIso8601String(),
    'personalData': personalData?.toJson(),
    'healthProfile': healthProfile,
  };
}
