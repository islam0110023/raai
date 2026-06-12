import 'package:raai/feature/caregivers/domain/entity/caregiver_list_entity.dart';

class CaregiverListModel {
  CaregiverListModel({
    this.caregiverId,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.isPrimary,
  });

  factory CaregiverListModel.fromJson(Map<String, dynamic> json) {
    return CaregiverListModel(
      caregiverId: json['caregiverId'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      isPrimary: json['isPrimary'] as bool?,
    );
  }
  int? caregiverId;
  String? name;
  String? email;
  String? phone;
  String? role;
  bool? isPrimary;

  Map<String, dynamic> toJson() => {
    'caregiverId': caregiverId,
    'name': name,
    'email': email,
    'phone': phone,
    'role': role,
    'isPrimary': isPrimary,
  };
  CaregiverListEntity toEntity() {
    return CaregiverListEntity(
      caregiverId: caregiverId!,
      name: name ?? '',
      email: email ?? '',
      phone: phone ?? '',
      role: role ?? '',
      isPrimary: isPrimary ?? false,
    );
  }
}
