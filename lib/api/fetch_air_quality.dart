import 'dart:convert';

import 'package:air_quality_app/api/api_key.dart';
import 'package:air_quality_app/model/air_quality/air_quality.dart';
import 'package:http/http.dart' as http;

class FetchAirQualityAPI {
  AirQuality? airQuality;

  //processing the data from response to Json
  Future<AirQuality> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    airQuality = AirQuality.fromJson(jsonString);
    return airQuality!;
  }
}

String apiURL(var lat, var lon) =>
    "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey";
