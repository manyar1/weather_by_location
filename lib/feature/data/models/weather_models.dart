import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';

class WeatherModels extends WeatherEntity {
  WeatherModels({required id, required main, required description, required icon})
      : super(id: id, main: main, description: description, icon: icon);

  factory WeatherModels.fromJson(Map<String, dynamic> json) {
    return WeatherModels(description: json['description'], icon: json['icon'], id: json['id'], main: json['main']);
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
