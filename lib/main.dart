import 'package:air_quality_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(primarySwatch:
          Colors.deepPurple, ),
      home: HomeSCreen(),
      title: "AirQuality",
      debugShowCheckedModeBanner: false,
    );
  }
}
