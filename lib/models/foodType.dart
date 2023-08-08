import 'dart:convert';

class FoodTypeModel {
  FoodTypeModel({
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

  factory FoodTypeModel.fromMap(Map<String, dynamic> map) {
    return FoodTypeModel(
      name: map['name'],
      id: map['id'],
    );
  }

  String toJSON() => json.encode(toMap());
}
