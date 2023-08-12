import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ColumnWeather extends StatelessWidget {
  final String weather;
  final String time;
  final String icon;
  const ColumnWeather({super.key, required this.weather, required this.time, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 42.w,
          child: Text(
            time,
            style: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        SvgPicture.asset(
          icon,
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          weather,
          style: GoogleFonts.roboto(fontSize: 17.sp, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ],
    );
  }
}
