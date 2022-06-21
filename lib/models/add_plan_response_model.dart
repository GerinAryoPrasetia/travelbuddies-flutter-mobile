import 'dart:convert';

AddPlanResponseModel addPlanResponseJson(String str) =>
    AddPlanResponseModel.fromJson(json.decode(str));

class AddPlanResponseModel {
  AddPlanResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  AddPlanResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.destinationName,
    required this.schedule,
    required this.people,
    required this.items,
    required this.transportation,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });
  late final String destinationName;
  late final String schedule;
  late final String people;
  late final String items;
  late final String transportation;
  late final int userId;
  late final String updatedAt;
  late final String createdAt;
  late final int id;

  Data.fromJson(Map<String, dynamic> json) {
    destinationName = json['destination_name'];
    schedule = json['schedule'];
    people = json['people'];
    items = json['items'];
    transportation = json['transportation'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['destination_name'] = destinationName;
    _data['schedule'] = schedule;
    _data['people'] = people;
    _data['items'] = items;
    _data['transportation'] = transportation;
    _data['user_id'] = userId;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    return _data;
  }
}
