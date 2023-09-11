/// current_weather : {"temperature":15.7,"weathercode":3}

class Weather {
  CurrentWeather? _currentWeather;
  Weather({
      CurrentWeather? currentWeather,}){
    _currentWeather = currentWeather;
}

  Weather.fromJson(dynamic json) {
    _currentWeather = json['current_weather'] != null ? CurrentWeather.fromJson(json['current_weather']) : null;
  }

Weather copyWith({  CurrentWeather? currentWeather,
}) => Weather(  currentWeather: currentWeather ?? _currentWeather,
);
  CurrentWeather? get currentWeather => _currentWeather;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_currentWeather != null) {
      map['current_weather'] = _currentWeather?.toJson();
    }
    return map;
  }

}

/// temperature : 15.7
/// weathercode : 3

class CurrentWeather {
  CurrentWeather({
      double? temperature,
      int? weathercode,}){
    _temperature = temperature;
    _weathercode = weathercode;
}

  CurrentWeather.fromJson(dynamic json) {
    _temperature = json['temperature'];
    _weathercode = json['weathercode'];
  }
  double? _temperature;
  int? _weathercode;
CurrentWeather copyWith({  double? temperature,
  int? weathercode,
}) => CurrentWeather(  temperature: temperature ?? _temperature,
  weathercode: weathercode ?? _weathercode,
);
  double? get temperature => _temperature;
  int? get weathercode => _weathercode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temperature'] = _temperature;
    map['weathercode'] = _weathercode;
    return map;
  }

}