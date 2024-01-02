import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_notes/theme/light_theme.dart';
import 'package:my_notes/view/home.dart';

Future<void> main() async {
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightTheme().themeLight,
      home: const HomeView(),
    );
  }
}
