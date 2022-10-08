// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentModelId {
  String id;
  String name;
  String age;
  String phone;
  String date;
  StudentModelId(
    this.id,
    this.name,
    this.age,
    this.phone,
    this.date,
  );

  StudentModelId copyWith({
    String? id,
    String? name,
    String? age,
    String? phone,
    String? date,
  }) {
    return StudentModelId(
      id ?? this.id,
      name ?? this.name,
      age ?? this.age,
      phone ?? this.phone,
      date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'phone': phone,
      'date': date,
    };
  }

  factory StudentModelId.fromMap(Map<String, dynamic> map) {
    return StudentModelId(
      map['id'] as String,
      map['name'] as String,
      map['age'] as String,
      map['phone'] as String,
      map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModelId.fromJson(String source) =>
      StudentModelId.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentModelId(id: $id, name: $name, age: $age, phone: $phone, date: $date)';
  }

  @override
  bool operator ==(covariant StudentModelId other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.age == age &&
        other.phone == phone &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        age.hashCode ^
        phone.hashCode ^
        date.hashCode;
  }
}
