import 'dart:convert';

DestinationResponseModel destinationResponseJson(String str) =>
    DestinationResponseModel.fromJson(json.decode(str));

class DestinationResponseModel {
  DestinationResponseModel({
    required this.id,
    required this.destinationName,
    required this.description,
    required this.city,
    required this.address,
    required this.price,
    required this.facilities,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String destinationName;
  late final String description;
  late final String city;
  late final String address;
  late final int price;
  late final String facilities;
  late final String image;
  late final String createdAt;
  late final String updatedAt;

  DestinationResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    destinationName = json['destination_name'];
    description = json['description'];
    city = json['city'];
    address = json['address'];
    price = json['price'];
    facilities = json['facilities'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['destination_name'] = destinationName;
    _data['description'] = description;
    _data['city'] = city;
    _data['address'] = address;
    _data['price'] = price;
    _data['facilities'] = facilities;
    _data['image'] = image;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
