class NextMedication {

  factory NextMedication.fromJson(Map<String, dynamic> json) {
    return NextMedication(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as dynamic,
      time: json['time'] == null
          ? null
          : DateTime.parse(json['time'] as String),
    );
  }

  NextMedication({this.id, this.name, this.image, this.time});
  int? id;
  String? name;
  dynamic image;
  DateTime? time;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'time': time?.toIso8601String(),
  };
}
