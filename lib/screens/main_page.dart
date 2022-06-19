import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelbuddies_mobile/screens/account/account.dart';
import 'package:travelbuddies_mobile/screens/destination/destination.dart';
import 'package:travelbuddies_mobile/screens/home/home.dart';
import 'package:travelbuddies_mobile/screens/plan/plan.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    Home(),
    PlanPage(),
    DestinationPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(
          () {
            currentIndex = index;
          },
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: "Plan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: "Destination",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
