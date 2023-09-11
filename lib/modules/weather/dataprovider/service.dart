
import "dart:convert";

import "package:http/http.dart" as http;

import "../models/Weather.dart";
import "../models/location.dart";

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

class WeatherApi {
  WeatherApi({http.Client? httpClient}): _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  static const locationUrl = "https://geocoding-api.open-meteo.com/v1/";
  static const locationActionName = "search";


  static const weatherUrl = "https://api.open-meteo.com/v1/";
  static const weatherActionNme = "forecast";

  http.Response? response;
 Future<Location> getLocation(String cityName) async {

      var url = Uri.https(
          locationUrl, locationActionName, {"name": cityName, "count": "1"});
      response = await _httpClient.get(url);

      if (response?.statusCode == 200) {
        var body = jsonDecode(response?.body ?? "") as Map;
        if (!body.containsKey('results')) throw LocationNotFoundFailure();
        var results = body["results"] as List;
        if(results.isEmpty){
          throw LocationNotFoundFailure();
        }
        return Location.fromJson(results.first as Map<String,dynamic>);
      }
      throw LocationRequestFailure();
    }


  getWeather(String latitude, String longitude) async {
    try {
      var url = Uri.https(weatherUrl, weatherActionNme, {
        "latitude": latitude,
        "longitude": longitude,
        "current_weather": "true"
      });
      response = await _httpClient.get(url);
      if (response?.statusCode == 200) {
        var body = jsonDecode(response?.body ?? "") as Map<String,dynamic>;
        var result = body["current_weather"] as Map<String,dynamic>;
        if(result.isEmpty){
          throw WeatherNotFoundFailure();
        }
        return Weather.fromJson(result);
      }
      else{
        throw WeatherRequestFailure();
      }
    }catch(e){
      print(e);
    }
  }


}