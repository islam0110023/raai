class CaregiverListEntity {
  CaregiverListEntity({
    required this.caregiverId,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.isPrimary,
  });

  final int caregiverId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final bool isPrimary;
}
