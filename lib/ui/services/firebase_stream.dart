import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_by_location/ui/pages/login_page.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text('Что-то пошло не так!')));
        } else if (snapshot.hasData) {
          log(snapshot.data!.emailVerified.toString());
          return const LoginPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
