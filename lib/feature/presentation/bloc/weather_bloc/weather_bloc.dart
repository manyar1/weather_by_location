import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_by_location/core/error/failure.dart';
import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';
import 'package:weather_by_location/feature/domain/usecases/get_weather_usecases.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUsecases getEverything;

  WeatherBloc(this.getEverything) : super(const WeatherLoadingState(oldWeather: null)) {
    _setupEvents();
  }
  void _setupEvents() {
    on<GetWeatherEvent>(_onGetWeather, transformer: droppable());
  }

  Future<void> _onGetWeather(GetWeatherEvent event, Emitter emit) async {
    try {
      final response = await getEverything(PageWeatherParamsUsecases(lat: event.lat, lon: event.lon));
      await response.fold(
        (failure) => _onStateFailure(emit, failure),
        (weather) => _onGetEverythingSuccessful(emit, weather),
      );
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onGetEverythingSuccessful(Emitter emit, AllWeatherEntity weather) async {
    final prevState = state;
    if (prevState is! WeatherLoadedState) {
      emit(WeatherLoadedState(everythingWeather: weather));
    } else {
      emit(prevState.copywith(everythingWeather: weather));
    }
  }

  Future<void> _onStateFailure(Emitter emit, Failure failure) async {
    emit(WeatherErrorState(failure: failure));
  }
}
