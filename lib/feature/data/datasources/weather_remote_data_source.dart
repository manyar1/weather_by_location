import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:weather_by_location/core/error/exeptions.dart';
import 'package:weather_by_location/feature/data/models/all_weather_models.dart';

abstract class WeatherRemoteDataSource {
  Future<AllWeatherModels> getWeather(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});
  @override
  Future<AllWeatherModels> getWeather(double lat, double lon) async {
    try {
      final response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=ru&appid=07d37d27561c56eb58cb87cb4c69278b&units=metric',
      );
      if (response.statusCode == 200) {
        final weather = AllWeatherModels.fromJson(response.data);
        return weather;
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('$e');
      throw ServerException();
    }
  }
}
