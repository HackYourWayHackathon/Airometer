import 'dart:async';

import 'package:air_quality_app/controller/global_controller.dart';
import 'package:air_quality_app/model/air_quality/air_quality.dart';
import 'package:air_quality_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

void onBGServiceEnabled() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  service.onDataReceived.listen((event) {
    if (event!['action'] == 'stopService') {
      service.stopBackgroundService();
    }
  });

  Timer.periodic(const Duration(seconds: 10), (timer) async {
    final AirQuality airQuality = await globalController.getAirQualityData();
    int aqi = airQuality.list![0].main!.aqi!;
    if (aqi <= 3) {
      service.setNotificationInfo(
        title: 'Monitoring Air Quality',
        content: 'Air Quality: ${aqiText(aqi)}',
      );
    } else {
      service.setNotificationInfo(
        title: 'Poor Air Quality Warning!',
        content: 'Air Quality: ${aqiText(aqi)}',
    
      );
    }
  });
}

String aqiText(int aqi) {
  switch (aqi) {
    case 1:
      return 'Good';
    case 2:
      return 'Fair';
    case 3:
      return 'Moderate';
    case 4:
      return 'Poor';
    case 5:
      return 'Very Poor';
    default:
      return 'AQI';
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeSCreen(),
      title: "AirQuality",
      debugShowCheckedModeBanner: false,
    );
  }
}
