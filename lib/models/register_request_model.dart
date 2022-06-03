class RegisterRequestModel {
  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    required this.location,
  });
  late final String email;
  late final String password;
  late final String name;
  late final String age;
  late final String location;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    age = json['age'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['name'] = name;
    _data['age'] = age;
    _data['location'] = location;
    return _data;
  }
}
