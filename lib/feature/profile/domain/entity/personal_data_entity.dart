class PersonalDataEntity {
  PersonalDataEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.userId,
    required this.age,
    required this.fullName,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final DateTime birthDate;
  final String gender;
  final int userId;
  final int age;
}
