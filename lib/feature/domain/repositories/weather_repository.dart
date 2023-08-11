import 'package:dartz/dartz.dart';
import 'package:weather_by_location/core/error/failure.dart';
import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';


abstract class WeatherRepository {
  Future<Either<Failure, AllWeatherEntity>> getWeather(double lat, double lon);
}
