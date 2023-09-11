import 'package:blocweather/modules/weather/dataprovider/service.dart';

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

class Weather {
  double? temperature;
  String? location;
  WeatherCondition? condition;

  Weather(
      {required this.temperature,
      required int weatherCode,
      required this.location}) {
    switch (weatherCode) {
      case 0:
        condition = WeatherCondition.clear;
      case 48:
        condition = WeatherCondition.cloudy;
      case 99:
        condition = WeatherCondition.rainy;
      case 86:
        condition = WeatherCondition.snowy;
      default:
        condition = WeatherCondition.unknown;
    }
  }
}

class WeatherRepository {
  final WeatherApi _weatherApi;
  WeatherRepository({required WeatherApi weatherApi})
      : _weatherApi = weatherApi;

  getWeather(String city) async {
    try {
      var location = await _weatherApi.getLocation(city);
      var latitude = location.results?[0].latitude?.toString();
      var longitude = location.results?[0].longitude?.toString();
      var weather =
          await _weatherApi.getWeather(latitude ?? "", longitude ?? "");
    } catch (e) {
      print(e);
    }
  }
}
