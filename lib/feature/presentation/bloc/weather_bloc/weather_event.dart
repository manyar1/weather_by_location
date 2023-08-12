part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object?> get props => [];
}

class GetWeatherEvent extends WeatherEvent {
  final double lat;
  final double lon;
  final Completer? completer;
  const GetWeatherEvent({required this.lat, required this.lon, this.completer});
  @override
  List<Object?> get props => [lat, lon, completer];
}
