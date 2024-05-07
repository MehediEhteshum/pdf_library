import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: _appBarTheme(),
  );
}

AppBarTheme _appBarTheme() => const AppBarTheme(
      color: Colors.amber,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: kToolbarHeight * 0.5,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    );
