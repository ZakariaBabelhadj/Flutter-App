import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/welcome/WelcomeScreen.dart';
import 'package:flutter_application_3/theme.dart';

void main() {
  runApp(MyApp());
}

// Chat App Change With Theme of the phone
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: WelcomeScreen(),
    );
  }
}
