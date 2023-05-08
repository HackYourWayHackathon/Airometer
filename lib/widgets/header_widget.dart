import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import '../controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  final GlobalController globalController;
  const HeaderWidget({super.key, required this.globalController});
  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String state = "";
  String country = "";
  String date = DateFormat("yMMMd").format(DateTime.now());

  @override
  void initState() {
    final GlobalController globalController = widget.globalController;
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = (place.locality ??
          place.subAdministrativeArea ??
          place.subLocality ??
          place.name ??
          place.street)!;
      state = (place.administrativeArea ?? place.subAdministrativeArea)!;
      country = place.country!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(
              fontSize: 35,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            '$state, $country',
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 77, 77, 77),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 77, 77, 77),
                height: 1.5),
          ),
        )
      ],
    );
  }
}
