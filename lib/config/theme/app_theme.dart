import 'package:flutter/material.dart';

class AppTheme{

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Color.fromRGBO(13, 34, 48, 1),
    brightness: Brightness.dark,
  
  );
}