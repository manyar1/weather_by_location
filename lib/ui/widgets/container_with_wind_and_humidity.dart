import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_by_location/common/colors/app_colors.dart';
import 'package:weather_by_location/core/constants/images.dart';
import 'package:weather_by_location/feature/domain/entities/weather_entity.dart';

class ContainerWithWindAndHumidity extends StatelessWidget {
  final AllWeatherEntity weather;
  const ContainerWithWindAndHumidity({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      width: 327.w,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
        child: Column(children: [
          Row(
            children: [
              SvgPicture.asset(
                Images.wind,
              ),
              SizedBox(
                width: 8.w,
              ),
              SizedBox(
                width: 56.w,
                child: Text(
                  '${weather.wind!.speed.toString().substring(0, weather.wind!.speed.toString().indexOf('.'))} м/с',
                  style:
                      GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w500, color: AppColors.containerColor),
                ),
              ),
              SizedBox(
                width: 24.w,
              ),
              Text(
                _directionOfTheWind(),
                style: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                Images.drop,
              ),
              SizedBox(
                width: 8.w,
              ),
              SizedBox(
                width: 56.w,
                child: Text(
                  '${weather.main!.humidity}%',
                  style:
                      GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w500, color: AppColors.containerColor),
                ),
              ),
              SizedBox(
                width: 24.w,
              ),
              Text(
                _airWithRelativeHumidity(),
                style: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  String _airWithRelativeHumidity() {
    if (weather.main!.humidity! <= 55) {
      return 'Низкая влажность';
    }
    if (weather.main!.humidity! >= 56 && weather.main!.humidity! <= 70) {
      return 'Привычная влажность';
    }
    if (weather.main!.humidity! >= 71 && weather.main!.humidity! <= 85) {
      return 'Умеренная влажность';
    }
    if (weather.main!.humidity! >= 85) {
      return 'Сильная влажность';
    }
    return '';
  }

  String _directionOfTheWind() {
    if ((weather.wind!.deg! >= 350 && weather.wind!.deg! <= 360) ||
        (weather.wind!.deg! >= 0 && weather.wind!.deg! <= 10)) {
      return 'Ветер северный';
    }
    if (weather.wind!.deg! >= 11 && weather.wind!.deg! <= 80) {
      return 'Ветер северо-восточный';
    }
    if (weather.wind!.deg! >= 81 && weather.wind!.deg! <= 100) {
      return 'Ветер восточный';
    }
    if (weather.wind!.deg! >= 101 && weather.wind!.deg! <= 170) {
      return 'Ветер юго-восточный';
    }
    if (weather.wind!.deg! >= 171 && weather.wind!.deg! <= 190) {
      return 'Ветер южный';
    }
    if (weather.wind!.deg! >= 191 && weather.wind!.deg! <= 260) {
      return 'Ветер юго-западный';
    }
    if (weather.wind!.deg! >= 261 && weather.wind!.deg! <= 280) {
      return 'Ветер западный';
    }
    if (weather.wind!.deg! >= 281 && weather.wind!.deg! <= 349) {
      return 'Ветер северо-западный';
    }
    return '';
  }
}
