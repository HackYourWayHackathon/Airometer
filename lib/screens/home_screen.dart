import 'package:air_quality_app/controller/global_controller.dart';
import 'package:air_quality_app/screens/search_location.dart';
import 'package:air_quality_app/widgets/components_widget.dart';
import 'package:air_quality_app/widgets/header_widget.dart';
import 'package:air_quality_app/widgets/notification_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widgets/aqi_data_widget.dart';

class HomeSCreen extends StatefulWidget {
  const HomeSCreen({super.key});

  @override
  State<HomeSCreen> createState() => _HomeSCreenState();
}

class _HomeSCreenState extends State<HomeSCreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  void searchBut() {
    Future.delayed(const Duration(seconds: 1));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     

      //AppBar
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromRGBO(0, 77, 64, 1)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: searchBut,
            icon: const Icon(
              Icons.search,
              color: Color.fromRGBO(0, 77, 64, 1),
              
            ),
          )
        ],
      ),

      body: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? const Center(child: CircularProgressIndicator())
              : ListView(children: [
                  const SizedBox(height: 10),
                  HeaderWidget(globalController: globalController),
                  AQIDataWidget(
                    airQuality: globalController.getAirQualityData(),
                  ),
                  const SizedBox(height: 50),
                  ComponentsWidget(
                      airQuality: globalController.getAirQualityData()),
                  const SizedBox(height: 10),
                  const BGServiceSwitch(),
                ]))),
    );
  }
}
