import 'package:raai/feature/caregiver/profile_caregiver/data/model/profile_caregiver_model/personal_data.dart';

class Profile {
  Profile({
    this.id,
    this.keycloakId,
    this.email,
    this.phone,
    this.fullName,
    this.role,
    this.createdAt,
    this.lastReadingReminderSentAt,
    this.personalData,
    this.healthProfile,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json['id'] as int?,
    keycloakId: json['keycloakId'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    fullName: json['fullName'] as String?,
    role: json['role'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    lastReadingReminderSentAt: json['lastReadingReminderSentAt'] as dynamic,
    personalData: json['personalData'] == null
        ? null
        : PersonalData.fromJson(json['personalData'] as Map<String, dynamic>),
    healthProfile: json['healthProfile'] as dynamic,
  );
  int? id;
  String? keycloakId;
  String? email;
  String? phone;
  String? fullName;
  String? role;
  DateTime? createdAt;
  dynamic lastReadingReminderSentAt;
  PersonalData? personalData;
  dynamic healthProfile;

  Map<String, dynamic> toJson() => {
    'id': id,
    'keycloakId': keycloakId,
    'email': email,
    'phone': phone,
    'fullName': fullName,
    'role': role,
    'createdAt': createdAt?.toIso8601String(),
    'lastReadingReminderSentAt': lastReadingReminderSentAt,
    'personalData': personalData?.toJson(),
    'healthProfile': healthProfile,
  };
}
