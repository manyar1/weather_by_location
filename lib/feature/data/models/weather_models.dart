import 'package:weather_by_location/feature/data/models/weather_enum_model.dart';
import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';

class WeatherModels extends WeatherEntity {
  WeatherModels({required id, required main, required description, required icon})
      : super(id: id, main: main, description: description, icon: icon);

  factory WeatherModels.fromJson(Map<String, dynamic> json) {
    WeatherEnum weather;
    switch (json['main']) {
      case 'Rain':
        weather = WeatherEnum.rain;
        break;
      case 'Snow':
        weather = WeatherEnum.snow;
        break;
      case 'Tunderstorm':
        weather = WeatherEnum.thunderstorm;
        break;
      case 'Drizzle':
        weather = WeatherEnum.drizzle;
        break;
      case 'Clouds':
        weather = WeatherEnum.clouds;
        break;
      default:
        weather = WeatherEnum.rain;
    }
    return WeatherModels(description: json['description'], icon: json['icon'], id: json['id'], main: weather);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}
