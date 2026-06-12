import 'schedule.dart';

class NextMedication {
  factory NextMedication.fromJson(Map<String, dynamic> json) {
    return NextMedication(
      doseId: json['doseId'] as int?,
      medicationId: json['medicationId'] as int?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      form: json['form'] as dynamic,
      image: json['image'] as dynamic,
      scheduledTime: json['scheduledTime'] == null
          ? null
          : DateTime.parse(json['scheduledTime'] as String),
      schedule: json['schedule'] == null
          ? null
          : Schedule.fromJson(json['schedule'] as Map<String, dynamic>),
    );
  }

  NextMedication({
    this.doseId,
    this.medicationId,
    this.name,
    this.category,
    this.form,
    this.image,
    this.scheduledTime,
    this.schedule,
  });
  int? doseId;
  int? medicationId;
  String? name;
  String? category;
  String? form;
  String? image;
  DateTime? scheduledTime;
  Schedule? schedule;

  Map<String, dynamic> toJson() => {
    'doseId': doseId,
    'medicationId': medicationId,
    'name': name,
    'category': category,
    'form': form,
    'image': image,
    'scheduledTime': scheduledTime?.toIso8601String(),
    'schedule': schedule?.toJson(),
  };
}
