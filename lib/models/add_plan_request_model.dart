class PlanRequestModel {
  PlanRequestModel({
    required this.destinationName,
    required this.schedule,
    required this.people,
    required this.transportation,
    required this.items,
  });
  late final String destinationName;
  late final String schedule;
  late final String people;
  late final String transportation;
  late final String items;

  PlanRequestModel.fromJson(Map<String, dynamic> json) {
    destinationName = json['destination_name'];
    schedule = json['schedule'];
    people = json['people'];
    transportation = json['transportation'];
    items = json['items'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['destination_name'] = destinationName;
    _data['schedule'] = schedule;
    _data['people'] = people;
    _data['transportation'] = transportation;
    _data['items'] = items;
    return _data;
  }
}
