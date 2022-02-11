import 'package:flutter/material.dart';

lightTheme(context) => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 20.0,
        backgroundColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: Theme.of(context).textTheme.headline6!.copyWith(
              fontFamily: 'firecode',
              fontWeight: FontWeight.bold,
            ),
        color: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        // systemOverlayStyle:
        //     const SystemUiOverlayStyle(statusBarColor: Colors.white),
      ),
    );
