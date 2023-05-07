import 'package:air_quality_app/controller/global_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? const Center(child: CircularProgressIndicator())
              : ListView(children: [
                  const SizedBox(height: 50),
                  const HeaderWidget(),
                  AQIDataWidget(
                    airQuality: globalController.getAirQualityData(),
                  ),
                  const SizedBox(height: 50),
                  ComponentsWidget(
                      airQuality: globalController.getAirQualityData()),
                  const BGServiceSwitch(),
                ]))),
    );
  }
}
