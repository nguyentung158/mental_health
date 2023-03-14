import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_app/screens/auth_screens/get_started_screen.dart';
import 'package:mental_health_app/screens/auth_screens/login_screen.dart';
import 'package:mental_health_app/screens/auth_screens/sign_up_flow_screens/flow_sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(24, 34, 58, 1),
        ),
        fontFamily: GoogleFonts.urbanist().fontFamily,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(24, 34, 58, 1),
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
              headline3: const TextStyle(
                color: Color.fromRGBO(24, 34, 58, 1),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              headline4: const TextStyle(
                color: Color.fromRGBO(24, 34, 58, 1),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              headline6: const TextStyle(
                color: Color.fromRGBO(24, 34, 58, 1),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              headline1: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
      ),
      home: const GetStartScreen(),
      routes: {
        FlowSignUpScreen.route: (context) => const FlowSignUpScreen(),
        LoginScreen.route: (context) => LoginScreen()
      },
    );
  }
}
