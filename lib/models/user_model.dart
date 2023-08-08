import 'dart:convert';
import 'package:cookley/models/user_settings_model.dart';

class UserModel {
  UserModel({
    required this.fullName,
    required this.gender,
    required this.age,
    required this.typeOfCuisine,
    required this.avatar,
    required this.settings,
    required this.mobileNumber,
    required this.foodType,
    this.favorites,
  });

  String fullName;
  String gender;
  String age;
  String typeOfCuisine;
  String avatar;
  UserSettingsModel settings;
  String mobileNumber;
  String foodType;
  List<String>? favorites = [];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'gender': gender,
      'age': age,
      'typeOfCuisine': typeOfCuisine,
      'avatar': avatar,
      'settings': settings,
      'mobileNumber': mobileNumber,
      'foodType': foodType,
      'favorites': favorites,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'],
      gender: map['gender'],
      age: map['age'],
      typeOfCuisine: map['typeOfCuisine'],
      avatar: map['avatar'],
      settings: UserSettingsModel.fromMap(map['settings']),
      mobileNumber: map['mobileNumber'],
      foodType: map['foodType'],
      favorites: map['favorites'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
