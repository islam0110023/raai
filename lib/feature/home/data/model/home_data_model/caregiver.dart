class Caregiver {
  Caregiver({this.id, this.name, this.phone, this.email});

  factory Caregiver.fromJson(Map<String, dynamic> json) => Caregiver(
    id: json['id'] as int?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    email: json['email'] as String?,
  );
  int? id;
  String? name;
  String? phone;
  String? email;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
  };
}
