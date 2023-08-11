part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object?> get props => [];
}

class WeatherLoadingState extends WeatherState {
  final AllWeatherEntity? oldWeather;

  const WeatherLoadingState({required this.oldWeather});
  @override
  List<Object?> get props => [oldWeather];
}

class WeatherLoadedState extends WeatherState {
  final AllWeatherEntity everythingWeather;

  const WeatherLoadedState({required this.everythingWeather, required});

  WeatherLoadedState copywith({
    AllWeatherEntity? everythingWeather,
  }) {
    return WeatherLoadedState(everythingWeather: everythingWeather ?? this.everythingWeather);
  }

  @override
  List<Object?> get props => [everythingWeather];
}

class WeatherErrorState extends WeatherState {
  final Failure failure;

  const WeatherErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
