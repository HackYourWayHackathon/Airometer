
import 'package:air_quality_app/controller/global_controller.dart';

import 'package:air_quality_app/widgets/aqi_data_widget.dart';
import 'package:air_quality_app/widgets/components_widget.dart';
import 'package:air_quality_app/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewLocationscreen extends StatelessWidget {
  final GlobalController globalController;
  final double lat, lon;

  const NewLocationscreen(
      {Key? key,
      required this.lat,
      required this.lon,
      required this.globalController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    globalController.getLocationByCoordinates(lat, lon);
    return Scaffold(
      //AppBar
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromRGBO(0, 77, 64, 1)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                ]))),
    );
  }
}
