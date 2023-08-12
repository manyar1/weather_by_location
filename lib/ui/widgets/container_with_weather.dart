import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_by_location/common/colors/app_colors.dart';
import 'package:weather_by_location/core/constants/images.dart';
import 'package:weather_by_location/feature/data/models/weather_enum_model.dart';
import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';
import 'package:weather_by_location/ui/widgets/column_weather.dart';

class ContainerWithWeather extends StatelessWidget {
  final AllWeatherEntity weather;
  const ContainerWithWeather({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    var month = [
      "январь",
      "февраль",
      "март",
      "апрель",
      "май",
      "июнь",
      "июль",
      "август",
      "сентябрь",
      "октябрь",
      "ноябрь",
      "декабрь"
    ];
    return Container(
      height: 230.h,
      width: 327.w,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Сегодня',
                  style: GoogleFonts.roboto(fontSize: 17.sp, fontWeight: FontWeight.w400, color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    '${DateTime.now().day} ${month[DateTime.now().month - 1]}',
                    style: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 32.w),
            child: Row(
              children: [
                ColumnWeather(
                  time: '${_timeWithZero('${DateTime.now().hour - 2}')}:${_timeWithZero('${DateTime.now().minute}')}',
                  icon: Images.sun,
                  weather: '15º',
                ),
                SizedBox(
                  width: 16.w,
                ),
                SizedBox(
                  width: 74.w,
                  height: 142.h,
                  child: Container(
                    width: 74.w,
                    height: 142.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: AppColors.choosenContainerColor,
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    ),
                    child: ColumnWeather(
                      time: '${_timeWithZero('${DateTime.now().hour}')}:${_timeWithZero('${DateTime.now().minute}')}',
                      icon: _weatherImage(weather),
                      weather:
                          '${weather.main!.temp.toString().substring(0, weather.main!.temp.toString().indexOf('.'))}º',
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                ColumnWeather(
                  time: '${_timeWithZero('${DateTime.now().hour + 2}')}:${_timeWithZero('${DateTime.now().minute}')}',
                  icon: Images.cloudLightning,
                  weather: '20º',
                ),
                SizedBox(
                  width: 31.w,
                ),
                ColumnWeather(
                  time: '${_timeWithZero('${DateTime.now().hour + 4}')}:${_timeWithZero('${DateTime.now().minute}')}',
                  icon: Images.snow,
                  weather: '18º',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _weatherImage(AllWeatherEntity weather) {

    switch (weather.weather!.first.main) {
      case WeatherEnum.rain:
        return Images.rain;
      case WeatherEnum.snow:
        return Images.snow;
      case WeatherEnum.clouds:
        return Images.cloudSun;
      case WeatherEnum.thunderstorm:
        return Images.cloudLightning;
      case WeatherEnum.drizzle:
        return Images.rain;
    }
  }

  String _timeWithZero(String time) {
    switch (time) {
      case '0':
        return '00';
      case '1':
        return '01';
      case '2':
        return '02';
      case '3':
        return '03';
      case '4':
        return '04';
      case '5':
        return '05';
      case '6':
        return '06';
      case '7':
        return '07';
      case '8':
        return '08';
      case '9':
        return '09';
      default:
        return time;
    }
  }
}
