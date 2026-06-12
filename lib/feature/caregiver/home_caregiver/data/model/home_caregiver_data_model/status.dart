import 'package:raai/core/utils/app_color.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/model/home_caregiver_data_model/home_caregiver_status.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_status_data_entity.dart';

class Status {
  Status({this.code, this.label});

  factory Status.fromJson(Map<String, dynamic> json) =>
      Status(code: json['code'] as String?, label: json['label'] as String?);
  String? code;
  String? label;

  Map<String, dynamic> toJson() => {'code': code, 'label': label};
  HomeCaregiverElderStatusDataEntity toEntity() {
    return HomeCaregiverElderStatusDataEntity(
      code: code ?? '',
      label: label ?? '',
      trafficColor: code?.statusElderCaregiver ?? AppColor.greenNormal,
    );
  }
}
