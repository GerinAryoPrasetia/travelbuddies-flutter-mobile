import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travelbuddies_mobile/screens/home/detail_destination.dart';

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

  DestinationData({
    required this.id,
    required this.destinationName,
    required this.description,
    required this.city,
    required this.address,
    required this.price,
    required this.facilities,
    required this.image,
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
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
    );
  }
}

class DestinationPage extends StatefulWidget {
  const DestinationPage({Key? key}) : super(key: key);

  @override
  State<DestinationPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DestinationPage> {
  late Future<List<DestinationData>> futureData;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureData = fetchDestination();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destinations"),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            FutureBuilder<List<DestinationData>>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DestinationData> destinationData =
                        snapshot.requireData;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      // width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: destinationData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailDestination(
                                        name: destinationData[index]
                                            .destinationName,
                                        location:
                                            destinationData[index].address,
                                        desc:
                                            destinationData[index].description,
                                        img: destinationData[index].image,
                                        price: destinationData[index].price,
                                        address: destinationData[index].address,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          destinationData[index].image),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.darken),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                destinationData[index].destinationName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20.0,
                              )
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: const CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
