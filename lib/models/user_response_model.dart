import 'dart:convert';

UserResponseModel userResponseJson(String str) =>
    UserResponseModel.fromJson(jsonDecode(str));

class UserResponseModel {
  late final int id;
  late final String name;
  late final String age;
  late final String location;
  late final String email;

  UserResponseModel(
      {required this.id,
      required this.name,
      required this.age,
      required this.email,
      required this.location});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        email: json['email'],
        location: json['location']);
  }
}
