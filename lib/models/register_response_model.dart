import 'dart:convert';

RegisterResponseModel registerResponseJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.code,
    required this.message,
    required this.data,
    required this.token,
  });
  late final int code;
  late final String message;
  late final Data? data;
  late final String token;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data!.toJson();
    _data['token'] = token;
    return _data;
  }
}

class Data {
  Data({
    required this.name,
    required this.email,
    required this.age,
    required this.location,
    required this.role,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });
  late final String name;
  late final String email;
  late final String age;
  late final String location;
  late final String role;
  late final String updatedAt;
  late final String createdAt;
  late final int id;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    age = json['age'];
    location = json['location'];
    role = json['role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['age'] = age;
    _data['location'] = location;
    _data['role'] = role;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    return _data;
  }
}
