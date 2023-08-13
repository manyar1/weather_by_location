import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_by_location/feature/data/models/all_weather_models.dart';

abstract class WeatherLocalDataSource {
  Future<AllWeatherModels> getCachedWeather();
  Future<void> setWeatherToCache(AllWeatherModels weather);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<AllWeatherModels> getCachedWeather() async {
    final jsonWeather = sharedPreferences.getString('CACHED_WEATHER_LIST');
    if (jsonWeather == null || jsonWeather.isEmpty) return Future.value(json.decode(''));

    return Future.value(json.decode(jsonWeather));
  }

  @override
  Future<void> setWeatherToCache(AllWeatherModels weather) async {
    await sharedPreferences.setString('CACHED_WEATHER_LIST', weather.toString());
    log('Weather to write Cache: $weather');
  }
}
