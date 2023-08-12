import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:weather_by_location/feature/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_by_location/locator_service.dart';
import 'package:weather_by_location/ui/pages/login_page.dart';
import 'package:weather_by_location/ui/pages/weather_page.dart';
import 'package:weather_by_location/ui/screen/splash_screen.dart';
import 'package:weather_by_location/ui/services/firebase_stream.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  runApp(const WeatherByLocation());
}

class WeatherByLocation extends StatelessWidget {
  const WeatherByLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => sl<WeatherBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            builder: FlutterSmartDialog.init(),
            navigatorObservers: [FlutterSmartDialog.observer],
            debugShowCheckedModeBanner: false,
            routes: {
              '/splash': (context) => const SplashScreen(),
              '/': (context) => const FirebaseStream(),
              '/login': (context) => const LoginPage(),
              '/weather': (context) => const WeatherPage(),
            },
            initialRoute: '/splash',
          );
        },
      ),
    );
  }
}
