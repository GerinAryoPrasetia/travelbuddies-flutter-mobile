import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelbuddies_mobile/models/destination_response_model.dart';
import 'package:travelbuddies_mobile/services/api_service.dart';
import 'package:travelbuddies_mobile/services/shared_services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<DestinationData>> fetchDestination() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/api/destination'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => DestinationData.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class DestinationData {
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

  DestinationData({
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

  factory DestinationData.fromJson(Map<String, dynamic> json) {
    return DestinationData(
      id: json['id'],
      destinationName: json['destination_name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      price: json['price'],
      facilities: json['facilities'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<DestinationData>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchDestination();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<List<DestinationData>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DestinationData> destinationData = snapshot.requireData;
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: destinationData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 75,
                          color: Colors.white,
                          child: Center(
                            child: Text(destinationData[index].destinationName),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
