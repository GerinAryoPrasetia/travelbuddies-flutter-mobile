import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:travelbuddies_mobile/screens/auth/login_page.dart';
import 'package:travelbuddies_mobile/screens/auth/register_page.dart';
import 'package:travelbuddies_mobile/screens/home/home.dart';
import 'package:travelbuddies_mobile/screens/splash_screen/splash.dart';
import 'package:travelbuddies_mobile/services/shared_services.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedServices.isLoggedIn();
  if (_result) {
    print(_result);
    _defaultHome = const Home();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        primaryColor: HexColor('#70DAD3'),
        backgroundColor: Colors.white,
        accentColor: HexColor("#EC8C6F"),
      ),
      // initialRoute: '/splash',
      routes: {
        '/': (context) => _defaultHome,
        '/splash': (context) => const Splash(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage()
      },
    );
  }
}
