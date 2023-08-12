import 'package:equatable/equatable.dart';
import 'package:weather_by_location/feature/data/models/weather_enum_model.dart';

class AllWeatherEntity extends Equatable {
  final CoordEntity? coord;
  final List<WeatherEntity>? weather;
  final String? base;
  final MainWeatherEntity? main;
  final int? visibility;
  final WindEntity? wind;
  final RainEntity? rain;
  final CloudsEntity? clouds;
  final int? dt;
  final SysEntity? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  const AllWeatherEntity(
      {required this.coord,
      required this.weather,
      required this.base,
      required this.main,
      required this.visibility,
      required this.wind,
      required this.rain,
      required this.clouds,
      required this.dt,
      required this.sys,
      required this.timezone,
      required this.id,
      required this.name,
      required this.cod});

  @override
  List<Object?> get props =>
      [coord, base, weather, main, visibility, wind, rain, clouds, dt, sys, timezone, id, name, cod];
}

class CoordEntity {
  double? lon;
  double? lat;

  CoordEntity({this.lon, this.lat});
}

class MainWeatherEntity {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  MainWeatherEntity(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});
}

class RainEntity {
  double? d1h;
  RainEntity({this.d1h});
}

class CloudsEntity {
  int? all;
  CloudsEntity({this.all});
}

class WindEntity {
  double? speed;
  int? deg;
  double? gust;
  WindEntity({this.speed, this.deg, this.gust});
}

class SysEntity {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;
  SysEntity({this.type, this.id, this.country, this.sunrise, this.sunset});
}

class WeatherEntity {
  int? id;
  WeatherEnum main;
  String? description;
  String? icon;
  WeatherEntity({this.id, required this.main, this.description, this.icon});
}
