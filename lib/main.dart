import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/home/home_screen.dart';
import 'package:social_media_app/screens/login/login_screen.dart';
import 'package:social_media_app/shared/cached/cached_helper.dart';
import 'package:social_media_app/shared/config/const.dart';
import 'package:social_media_app/shared/cubit/bloc_observer.dart';
import 'package:social_media_app/shared/styles/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachedHelper.initialSharedPreference();
  // await CachedHelper.clearData();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  static final String loginUid = CachedHelper.getData(key: kLoginUid) ?? '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      // themeMode: ThemeMode.dark,
      home: loginUid.isNotEmpty ? const HomeScreen() : const LoginScreen(),
    );
  }
}
