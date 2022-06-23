class EditUserRequestModel {
  String? name;
  String? age;
  String? email;
  String? location;

  EditUserRequestModel({this.name, this.age, this.email, this.location});

  EditUserRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    email = json['email'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['email'] = this.email;
    data['location'] = this.location;
    return data;
  }
}
