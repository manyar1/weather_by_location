import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_by_location/core/platform/network_info.dart';
import 'package:weather_by_location/feature/data/datasources/news_local_data_source.dart';
import 'package:weather_by_location/feature/data/datasources/weather_remote_data_source.dart';
import 'package:weather_by_location/feature/data/repository/weather_repository_impl.dart';
import 'package:weather_by_location/feature/domain/repositories/weather_repository.dart';
import 'package:weather_by_location/feature/domain/usecases/get_weather_usecases.dart';
import 'package:http/http.dart' as http;
import 'feature/presentation/bloc/weather_bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(() => WeatherBloc(sl()));
  //UseCases
  sl.registerLazySingleton(() => GetWeatherUsecases(sl()));
  //Repository
  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryUmpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(sl()),
  );
  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(
    http.Client.new,
  );
  sl.registerLazySingleton(
    InternetConnectionChecker.new,
  );
}
