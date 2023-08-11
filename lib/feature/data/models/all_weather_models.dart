import 'package:weather_by_location/feature/data/models/coord_models.dart';
import 'package:weather_by_location/feature/data/models/main_weather_models.dart';
import 'package:weather_by_location/feature/data/models/rain_clouds_wind_models.dart';
import 'package:weather_by_location/feature/data/models/sys_models.dart';
import 'package:weather_by_location/feature/data/models/weather_models.dart';
import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';

class AllWeatherModels extends AllWeatherEntity {
  const AllWeatherModels(
      {required coord,
      required weather,
      required base,
      required main,
      required visibility,
      required wind,
      required rain,
      required clouds,
      required dt,
      required sys,
      required timezone,
      required id,
      required name,
      required cod})
      : super(
            coord: coord,
            weather: weather,
            base: base,
            main: main,
            visibility: visibility,
            wind: wind,
            rain: rain,
            clouds: clouds,
            dt: dt,
            sys: sys,
            timezone: timezone,
            id: id,
            name: name,
            cod: cod);

  factory AllWeatherModels.fromJson(Map<String, dynamic> json) {
    final List<WeatherModels> weatherList = [];
    if (json['weather'] != null) {
      json['weather'].forEach((v) {
        weatherList.add(WeatherModels.fromJson(v));
      });
    }
    return AllWeatherModels(
      coord: json['coord'] != null ? CoordModels.fromJson(json['coord']) : null,
      base: json['base'],
      main: json['main'] != null ? MainWeatherModels.fromJson(json['main']) : null,
      visibility: json['visibility'],
      wind: json['wind'] != null ? WindModels.fromJson(json['wind']) : null,
      rain: json['rain'] != null ? RainModels.fromJson(json['rain']) : null,
      clouds: json['clouds'] != null ? CloudsModels.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? SysModels.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
      weather: weatherList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coord': coord,
      'base':base,
      'main': main,
      'visibility':visibility,
      'wind': wind,
      'rain':rain,
      'clouds':clouds,
      'dt':dt,
      'sys':sys,
      'timezone': timezone,
      'id':id,
      'name':name,
      'cod':cod,
      'weather': weather
    };
  }
}
