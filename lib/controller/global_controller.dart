import 'package:air_quality_app/api/fetch_air_quality.dart';
import 'package:air_quality_app/model/air_quality/air_quality.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final airQuality = AirQuality().obs;

  AirQuality getAirQualityData() => airQuality.value;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location is not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    //getting the current location
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((it) {
      //update the current location
      _latitude.value = it.latitude;
      _longitude.value = it.longitude;

      //calling our air quality api
      return FetchAirQualityAPI()
          .processData(_latitude.value, _longitude.value)
          .then((value) {
        airQuality.value = value;
        _isLoading.value = false;
      });
    });
  }

  getLocationByCoordinates(lat, lon) {
    _latitude.value = lat;
    _longitude.value = lon;
    return FetchAirQualityAPI()
        .processData(_latitude.value, _longitude.value)
        .then((value) {
      airQuality.value = value;
      _isLoading.value = false;
    });
  }
}
