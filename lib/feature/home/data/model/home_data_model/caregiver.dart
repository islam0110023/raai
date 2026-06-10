class Caregiver {

  Caregiver({this.id, this.name});

  factory Caregiver.fromJson(Map<String, dynamic> json) =>
      Caregiver(id: json['id'] as int?, name: json['name'] as String?);
  int? id;
  String? name;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
