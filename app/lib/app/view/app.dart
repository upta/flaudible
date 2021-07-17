import 'package:flaudible/landing/landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'FlAudible',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        brightness: Brightness.dark,
        bottomAppBarColor: const Color.fromARGB(255, 36, 39, 40),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 36, 39, 40),
          selectedItemColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
      ),
      debugShowCheckedModeBanner: false,
      home: const LandingScreen(),
    );
  }
}
