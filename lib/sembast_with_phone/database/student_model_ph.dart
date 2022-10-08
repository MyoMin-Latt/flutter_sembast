// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentModel {
  String name;
  String age;
  String phone;
  StudentModel(
    this.name,
    this.age,
    this.phone,
  );

  StudentModel copyWith({
    String? name,
    String? age,
    String? phone,
  }) {
    return StudentModel(
      name ?? this.name,
      age ?? this.age,
      phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'phone': phone,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      map['name'] as String,
      map['age'] as String,
      map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StudentModel(name: $name, age: $age, phone: $phone)';

  @override
  bool operator ==(covariant StudentModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age && other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ phone.hashCode;
}
