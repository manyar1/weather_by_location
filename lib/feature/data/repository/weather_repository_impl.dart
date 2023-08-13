import 'package:dartz/dartz.dart';
import 'package:weather_by_location/core/error/exeptions.dart';
import 'package:weather_by_location/core/error/failure.dart';
import 'package:weather_by_location/core/platform/network_info.dart';
import 'package:weather_by_location/feature/data/datasources/weather_local_data_source.dart';
import 'package:weather_by_location/feature/data/datasources/weather_remote_data_source.dart';
import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';
import 'package:weather_by_location/feature/domain/repositories/weather_repository.dart';

class WeatherRepositoryUmpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryUmpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, AllWeatherEntity>> getWeather(double lat, double lon) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getWeather(lat, lon);
        await localDataSource.setWeatherToCache(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedWeather = await localDataSource.getCachedWeather();
        return Right(cachedWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
