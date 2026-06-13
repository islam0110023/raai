import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_doses_all_medication_caregiver.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_elder_all_medication_caregiver_entity.dart';

class AllMedicationInCaregiverEntity {
  AllMedicationInCaregiverEntity({
    required this.taken,
    required this.missed,
    required this.upcoming,
    required this.snoozed,
    required this.elders,
    required this.doses,
  });

  final int taken;
  final int missed;
  final int upcoming;
  final int snoozed;
  final List<AllElderAllMedicationCaregiverEntity> elders;
  final List<AllDosesAllMedicationCaregiver> doses;
}
