import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_by_location/common/colors/app_colors.dart';
import 'package:weather_by_location/core/constants/images.dart';
import 'package:weather_by_location/core/utils/toasts.dart';
import 'package:weather_by_location/ui/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login(BuildContext context1) async {
    final navigator = Navigator.of(context);

    // final isValid = formKey.currentState!.validate();
    // if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        CustomAlert().showMessage('Неправильный email или пароль. Повторите попытку', context1);
        return;
      } else {
        CustomAlert().showMessage('Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.', context1);
        return;
      }
    }
    log('1');
    navigator.pushNamedAndRemoveUntil('/weather', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 48.h),
                  child: Text(
                    'Вход',
                    style: GoogleFonts.ubuntu(fontSize: 28.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Введите данные для входа',
                  style: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w400, color: AppColors.greyText),
                ),
                SizedBox(height: 40.h),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  controller: emailTextInputController,
                  validator: (email) {
                    log(email.toString());
                    return email != null && !EmailValidator.validate(email) ? 'Введите правильный Email' : null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.animate),
                      ),
                      labelText: "Email",
                      labelStyle:
                          GoogleFonts.roboto(fontSize: 17.sp, fontWeight: FontWeight.w400, color: AppColors.greyText)),
                ),
                SizedBox(height: 30.h),
                TextFormField(
                  autocorrect: false,
                  controller: passwordTextInputController,
                  obscureText: isHiddenPassword,
                  validator: (value) => value != null && value.length < 6 ? 'Минимум 6 символов' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.animate),
                    ),
                    labelStyle:
                        GoogleFonts.roboto(fontSize: 17.sp, fontWeight: FontWeight.w400, color: AppColors.greyText),
                    labelText: 'Пароль',
                    suffix: InkWell(
                      onTap: togglePasswordView,
                      child: !isHiddenPassword
                          ? SvgPicture.asset(
                              Images.openEye,
                            )
                          : SvgPicture.asset(
                              Images.closeEye,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  height: 48.h,
                  child: CustomButton(
                    onTap: () {
                      String error = 'Укажите';
                      bool errorsFlag = false;
                      String email = emailTextInputController.text;
                      bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
        
                      if (!emailValid && emailTextInputController.text.isNotEmpty) {
                        error += '\n- ${'Правильный email'}';
                        errorsFlag = true;
                      }
                      if (errorsFlag) {
                        log('1');
                        CustomAlert().showMessage(error, context);
                      } else {
                        login(context);
                      }
                    },
                    btnColor: AppColors.buttomColor,
                    label: Text(
                      'Войти',
                      style: GoogleFonts.roboto(fontSize: 17.sp, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
