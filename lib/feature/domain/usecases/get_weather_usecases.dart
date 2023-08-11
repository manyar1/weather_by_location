import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_by_location/core/error/failure.dart';
import 'package:weather_by_location/core/usecases/usecase.dart';
import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';
import 'package:weather_by_location/feature/domain/repositories/weather_repository.dart';

class GetWeatherUsecases extends UseCase<AllWeatherEntity, PageWeatherParamsUsecases> {
  final WeatherRepository weatherRepository;

  GetWeatherUsecases(this.weatherRepository);

  @override
  Future<Either<Failure, AllWeatherEntity>> call(PageWeatherParamsUsecases params) async {
    return weatherRepository.getWeather(params.lat, params.lon);
  }
}

class PageWeatherParamsUsecases extends Equatable {
  final double lat;
  final double lon;

  const PageWeatherParamsUsecases({
    required this.lon,
    required this.lat,
  });
  @override
  List<Object?> get props => [lon, lat];
}
