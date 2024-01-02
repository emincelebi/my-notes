import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightTheme {
  var themeLight = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorUtils.lightRed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
        left: Radius.circular(RadiusVariables.standartRad),
        right: Radius.circular(RadiusVariables.standartRad),
      )),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    scaffoldBackgroundColor: ColorUtils.blueGrey,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorUtils.lightRed,
    ),
    textTheme: const TextTheme(
        titleLarge: TextStyle(
      fontSize: 25,
      color: Colors.blue,
    )),
    useMaterial3: true,
  );
}

class RadiusVariables {
  static const double standartRad = 20.0;
  static const double bigRad = 30.0;
  static const double smallRad = 10.0;
}

class ColorUtils {
  static const Color lightRed = Color.fromARGB(255, 192, 42, 31);
  static const Color yellow = Colors.yellow;
  static Color teal = Colors.teal.shade400;
  static Color blueGrey = Colors.blueGrey;
}
