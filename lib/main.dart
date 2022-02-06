import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/login/login_screen.dart';
import 'package:social_media_app/shared/config/light_theme.dart';
import 'package:social_media_app/shared/cubit/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: LoginScreen(),
    );
  }
}
