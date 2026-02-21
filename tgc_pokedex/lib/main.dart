// main.dart

import 'package:flutter/material.dart';
import 'package:tgc_pokedex/views/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokéDex TCG',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Color(0xFFEE1515),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}