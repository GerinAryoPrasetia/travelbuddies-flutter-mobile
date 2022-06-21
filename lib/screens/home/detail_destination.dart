import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailDestination extends StatefulWidget {
  final String name;
  final String location;
  final String desc;
  final String img;
  final int price;
  final String address;
  DetailDestination(
      {required this.name,
      required this.location,
      required this.desc,
      required this.img,
      required this.price,
      required this.address});
  @override
  State<DetailDestination> createState() => _DetailDestinationState();
}

class _DetailDestinationState extends State<DetailDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.img),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(widget.desc),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    direction: Axis.horizontal, // main axis (rows or columns)
                    children: [
                      const Text(
                        'Address : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.address)
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Price : ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.price.toString())
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
