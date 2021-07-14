import 'package:app/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'FlAudible',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        brightness: Brightness.dark,
        bottomAppBarColor: const Color.fromARGB(255, 36, 39, 40),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 36, 39, 40),
          selectedItemColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
      ),
      debugShowCheckedModeBanner: false,
      home: NavScreen(),
    );
  }
}
