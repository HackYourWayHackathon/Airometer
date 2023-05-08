import 'package:air_quality_app/model/air_quality/components.dart';
import 'package:flutter/material.dart';

import '../model/air_quality/air_quality.dart';

class ComponentsWidget extends StatelessWidget {
  final AirQuality airQuality;

  const ComponentsWidget({Key? key, required this.airQuality})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int aqi = airQuality.list![0].main!.aqi!;
    Components components = airQuality.list![0].components!;
    double no, co, no2, o3, so2, pm25, pm10, nh3;

    no = components.no!;
    co = components.co!;
    no2 = components.no2!;
    o3 = components.o3!;
    so2 = components.so2!;
    pm25 = components.pm25!;
    pm10 = components.pm10!;
    nh3 = components.nh3!;

    var labelArray = ['NO', 'CO', 'NO2', 'O3', 'SO2', 'PM2.5', 'PM10', 'NH3'];
    var valueArray = [no, co, no2, o3, so2, pm25, pm10, nh3];

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          // padding: EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          children: List.generate(8, (index) {
            return Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 223, 223),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: progressColor(aqi))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    labelArray[index],
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${valueArray[index]}',
                    style: TextStyle(
                        color: progressColor(aqi),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          })),
    );
  }

  Color progressColor(int aqi) {
    switch (aqi) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return const Color.fromRGBO(218, 168, 7, 1);
      case 4:
        return const Color.fromARGB(255, 243, 67, 55);
      case 5:
        return const Color.fromARGB(255, 138, 10, 1);
      default:
        return Colors.blue;
    }
  }
}
