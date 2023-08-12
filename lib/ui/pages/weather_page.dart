import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_by_location/common/colors/app_colors.dart';
import 'package:weather_by_location/core/constants/images.dart';
import 'package:weather_by_location/feature/data/models/weather_enum_model.dart';
import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';
import 'package:weather_by_location/feature/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_by_location/ui/widgets/container_with_weather.dart';
import 'package:weather_by_location/ui/widgets/container_with_wind_and_humidity.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Position? position;
  @override
  void initState() {
    geolocator();

    super.initState();
  }

  void geolocator() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    log(position!.latitude.toString());
    log(position!.longitude.toString());

    if (position != null) {
      getWeather();
    }
  }

  void getWeather() async {
    final completer = Completer();
    context
        .read<WeatherBloc>()
        .add(GetWeatherEvent(lat: position!.latitude, lon: position!.longitude, completer: completer));
    await completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundColor, AppColors.backgroundColorGradient],
            begin: Alignment.topCenter,
            end: Alignment(0.80, 1),
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is WeatherLoadedState) {
              final weather = state.everythingWeather;
              return RefreshIndicator(
                onRefresh: () async {
                  geolocator();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 25.h,
                                left: 28.w,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.path,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    '${weather.name}, ${_countryCode(weather)}',
                                    style: GoogleFonts.roboto(
                                        fontSize: 17.sp, fontWeight: FontWeight.w500, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              Images.ellipse,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 62.h),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                _weatherImage(weather),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 252.h),
                            child: Text(
                              '${weather.main!.temp.toString().substring(0, weather.main!.temp.toString().indexOf('.'))}º',
                              style:
                                  GoogleFonts.ubuntu(fontSize: 64.sp, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Text(
                        _weatherText(weather),
                        style: GoogleFonts.roboto(fontSize: 17.sp, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'Макс.: ${weather.main!.tempMax.toString().substring(0, weather.main!.temp.toString().indexOf('.'))}º Мин.: ${weather.main!.tempMin.toString().substring(0, weather.main!.temp.toString().indexOf('.'))}º',
                        style: GoogleFonts.roboto(fontSize: 17.sp, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      ContainerWithWeather(weather: weather),
                      SizedBox(
                        height: 24.h,
                      ),
                      ContainerWithWindAndHumidity(weather: weather),
                      SizedBox(
                        height: 60.h,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }

  String _countryCode(AllWeatherEntity weather) {
    switch (weather.sys!.country) {
      case 'RU':
        return 'Россия';
      case 'US':
        return 'США';

      default:
        return weather.sys!.country!;
    }
  }

  String _weatherImage(AllWeatherEntity weather) {
    switch (weather.weather!.first.main) {
      case WeatherEnum.rain:
        return Images.bigRain;
      case WeatherEnum.snow:
        return Images.bigSnow;
      case WeatherEnum.clouds:
        return Images.bigSun;
      case WeatherEnum.thunderstorm:
        return Images.bigThunderstorm;
      case WeatherEnum.drizzle:
        return Images.bigRainAndSun;
    }
  }

  String _weatherText(AllWeatherEntity weather) {
    switch (weather.weather!.first.main) {
      case WeatherEnum.rain:
        return 'Дождь';
      case WeatherEnum.snow:
        return 'Снег';
      case WeatherEnum.clouds:
        return 'Облачно';
      case WeatherEnum.thunderstorm:
        return 'Гроза';
      case WeatherEnum.drizzle:
        return 'Моросит';
    }
  }
}
