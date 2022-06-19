import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelbuddies_mobile/models/destination_response_model.dart';
import 'package:travelbuddies_mobile/models/plan_response.dart';
import 'package:travelbuddies_mobile/models/user_response_model.dart';
import 'package:travelbuddies_mobile/screens/account/account.dart';
import 'package:travelbuddies_mobile/screens/destination/destination.dart';
import 'package:travelbuddies_mobile/screens/home/detail_destination.dart';
import 'package:travelbuddies_mobile/screens/plan/plan.dart';
import 'package:travelbuddies_mobile/services/api_service.dart';
import 'package:travelbuddies_mobile/services/shared_services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

//TODO: get token from local data
// Future<UserData> fetchUser() async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? token = prefs.getString('key');
//   final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/user'));
// }

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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: FutureBuilder<UserResponseModel>(
              future: APIService.getUserProfile(),
              builder: (BuildContext context,
                  AsyncSnapshot<UserResponseModel> model) {
                if (model.hasData) {
                  print(model.data!.name);
                  return Text(
                    "Hi!, ${model.data!.name}",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  );
                }
                return const Text("Please Login");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Best Destination",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DestinationPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder<List<DestinationData>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DestinationData> destinationData = snapshot.requireData;
                return Container(
                  height: 250.0,
                  // width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
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
                                    name:
                                        destinationData[index].destinationName,
                                    location: destinationData[index].address,
                                    desc: destinationData[index].description,
                                    img: destinationData[index].image,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              width: 150,
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
                              // child: Column(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: <Widget>[

                              //     SizedBox(
                              //       height: 20.0,
                              //     )
                              //   ],
                              // ),
                            ),
                          ),
                          Text(
                            destinationData[index].destinationName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Plan",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlanPage(),
                          ),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder<List<PlanResponseModel>>(
            future: APIService.getUserPlan(),
            builder: (context, snapshot) {
              print(snapshot.hasData);
              if (snapshot.hasData) {
                List<PlanResponseModel> planData = snapshot.requireData;
                print(planData);
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: planData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).colorScheme.background),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    planData[index].destinationName!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    planData[index].schedule!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          )
                        ],
                      );
                    },
                  ),
                );
              }
              return const Text('add Plan');
            },
          ),
        ],
      ),
    );
  }
}
