import 'dart:convert';

class TypeOfCusines {
  TypeOfCusines({
    required this.name,
    required this.id,
  });

  String name;
  String id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory TypeOfCusines.fromMap(Map<String, dynamic> map) {
    return TypeOfCusines(
      name: map['name'],
      id: map['id'],
    );
  }

  String toJSON() => json.encode(toMap());
}
