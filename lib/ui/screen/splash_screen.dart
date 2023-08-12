import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_by_location/common/colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.backgroundColor, AppColors.backgroundColorGradient],
          begin: Alignment.topCenter,
          end: Alignment(1, 1),
        ),
      ),
      child: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 272.w, right: 87.w, left: 43.w),
              child: Text(
                'WEATHER\nSERVICE',
                style: GoogleFonts.inter(fontSize: 48.sp, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 270.w,
              ),
              child: Text(
                'dawn is coming soon',
                style: GoogleFonts.inter(fontSize: 24.sp, fontWeight: FontWeight.w300, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
