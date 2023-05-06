import 'package:flutter/material.dart';

import '../model/air_quality/air_quality.dart';

class ComponentsWidget extends StatelessWidget {
  final AirQuality airQuality;

  const ComponentsWidget({Key? key, required this.airQuality})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
      crossAxisCount: 4,
      // padding: EdgeInsets.all(10),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Hello',
          ),
        ),
      ],
    ));
  }
}
