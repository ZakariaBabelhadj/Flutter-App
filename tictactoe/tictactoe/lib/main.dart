import 'package:flutter/material.dart';
import 'package:tictactoe/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}
