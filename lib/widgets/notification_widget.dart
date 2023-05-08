import 'package:air_quality_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';

class BGServiceSwitch extends StatefulWidget {
  const BGServiceSwitch({super.key});

  @override
  State<BGServiceSwitch> createState() => _BGServiceSwitchState();
}

class _BGServiceSwitchState extends State<BGServiceSwitch> {
  bool isRunning = false;
  String textEnable = 'Enable poor AQI alerts';
  String textDisable = 'Disable poor AQI alerts';

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Permission.notification.isDenied
        .then((value) => Permission.notification.request());
    FlutterBackgroundService.initialize(onBGServiceEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: GestureDetector(
        onTap: () async {
          var isRunning = await FlutterBackgroundService().isServiceRunning();
          if (isRunning) {
            FlutterBackgroundService().sendData({'action': 'stopService'});
          } else {
            FlutterBackgroundService.initialize(onBGServiceEnabled);
          }
          setState(() {
            this.isRunning = isRunning;
          });
        },
        child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            width: double.infinity,
            decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: const Color.fromRGBO(0, 77, 64, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Text(
              (isRunning) ? textEnable : textDisable,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ))),
      ),
    );
  }
}
