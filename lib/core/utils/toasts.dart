import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_by_location/common/colors/app_colors.dart';

class CustomAlert {
  void showMessage(
    String text,
    BuildContext context1) {
    SmartDialog.showToast(
      text,
      usePenetrate: false,
      clickMaskDismiss: true,
      consumeEvent: true,
      displayTime: const Duration(seconds: 3),
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 3,
              color: Color.fromRGBO(26, 42, 97, 0.06),
            ),
          ],
        ),
        child: MediaQuery(
          data: const MediaQueryData(textScaleFactor: 1.0),
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Text(
              text,
              style: GoogleFonts.roboto(fontSize: 17.sp, fontWeight: FontWeight.w400, color: AppColors.greyText),
            ),
          ),
        ),
      ),
      alignment: Alignment.topCenter,
      maskColor: Colors.transparent,
    );
  }
}
