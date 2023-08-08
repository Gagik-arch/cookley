import 'dart:convert';

class UserSettingsModel {
  UserSettingsModel({
    required this.language,
    required this.pushNotification,
  });

  String language;
  bool pushNotification = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'pushNotification': pushNotification,
    };
  }

  factory UserSettingsModel.fromMap(Map<String, dynamic> map) {
    return UserSettingsModel(
      language: map['language'] as String,
      pushNotification: map['pushNotification'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSettingsModel.fromJson(String source) =>
      UserSettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
