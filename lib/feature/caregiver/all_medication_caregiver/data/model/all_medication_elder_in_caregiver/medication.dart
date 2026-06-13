class Medication {
  int? id;
  String? name;
  String? image;
  dynamic form;

  Medication({this.id, this.name, this.image, this.form});

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as String?,
    form: json['form'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'form': form,
  };
}
