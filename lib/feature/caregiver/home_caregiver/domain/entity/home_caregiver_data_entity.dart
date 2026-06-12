import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_data_entity.dart';

class HomeCaregiverDataEntity {
  HomeCaregiverDataEntity({
    required this.caregiverId,
    required this.name,
    required this.good,
    required this.warning,
    required this.critical,
    required this.elders,
    required this.gender,
  });

  final int caregiverId;
  final String name;
  final int good;
  final int warning;
  final int critical;
  final String? gender;
  final List<HomeCaregiverElderDataEntity> elders;
}
