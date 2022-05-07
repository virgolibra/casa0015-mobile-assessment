import 'package:flutter/material.dart';
import './theme/custom_theme.dart';
import './page/first_page.dart';
import './page/home_page.dart';
import './page/map_test_page.dart';
import './page/weather_page.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Flutter App',
      theme: CustomTheme.lightTheme,
      home: const MyHomePage(title: 'CASA0015 Assessment'), // home:   MyHomePage(),
      routes: {
        '/first_page': (BuildContext context) => const FirstPage(),
        '/map_test_page': (BuildContext context) => const MapTestPage(),
        '/weather_page': (BuildContext context) => const WeatherPage(),


      },

    );
  }
}


