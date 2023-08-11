import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';

class MainWeatherModels extends MainWeatherEntity {
  MainWeatherModels({temp, feelsLike, tempMin, tempMax, pressure, humidity, seaLevel, grndLevel})
      : super(
            feelsLike: feelsLike,
            temp: temp,
            tempMin: tempMin,
            tempMax: tempMax,
            pressure: pressure,
            humidity: humidity,
            seaLevel: seaLevel,
            grndLevel: grndLevel);

  factory MainWeatherModels.fromJson(Map<String, dynamic> json) {
    return MainWeatherModels(
        temp: json['temp'],
        feelsLike: json['feels_like'],
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        seaLevel: json['sea_level'],
        grndLevel: json['grnd_level']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    return data;
  }
}
