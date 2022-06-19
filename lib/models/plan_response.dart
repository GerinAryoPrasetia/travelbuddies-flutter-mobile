import 'dart:convert';

// PlanResponseModel planResponseJson(str) =>
//     PlanResponseModel.fromJson(jsonDecode(str));

List<PlanResponseModel> planResponseJson(str) {
  List jsonResponse = json.decode(str);
  return jsonResponse.map((data) => PlanResponseModel.fromJson(data)).toList();
}

class PlanResponseModel {
  int? id;
  int? userId;
  String? destinationName;
  String? schedule;
  String? people;
  String? items;
  String? transportation;
  String? createdAt;
  String? updatedAt;

  PlanResponseModel(
      {this.id,
      this.userId,
      this.destinationName,
      this.schedule,
      this.people,
      this.items,
      this.transportation,
      this.createdAt,
      this.updatedAt});

  PlanResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    destinationName = json['destination_name'];
    schedule = json['schedule'];
    people = json['people'];
    items = json['items'];
    transportation = json['transportation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['destination_name'] = destinationName;
    data['schedule'] = schedule;
    data['people'] = people;
    data['items'] = items;
    data['transportation'] = transportation;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
