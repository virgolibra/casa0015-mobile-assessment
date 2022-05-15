import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_casa0015_mobile_app/page/message_test_page.dart';
import './theme/custom_theme.dart';
import './page/first_page.dart';
import './page/home_page.dart';
import './page/map_test_page.dart';
import './page/weather_page.dart';
import './page/login_page.dart';
import './page/spending_display_page.dart';
import './page/camera_test_page.dart';

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'authentication.dart';
import 'widgets.dart';


import 'splash.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Test App',
      // theme: ThemeData(
      //   buttonTheme: Theme.of(context).buttonTheme.copyWith(
      //         highlightColor: Colors.deepPurple,
      //       ),
      //   // primaryColor: Colors.yellow[700],
      //   primarySwatch: Colors.deepPurple,
      //   textTheme: GoogleFonts.robotoTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      theme: CustomTheme.lightTheme,
      // home: const LoginPage(), // home:   MyHomePage(),
      home: const Splash(), // home:   MyHomePage(),
      routes: {
        '/home_page': (BuildContext context) =>
            const MyHomePage(title: 'HomePage'),
        '/first_page': (BuildContext context) => const FirstPage(),
        '/map_test_page': (BuildContext context) => const MapTestPage(),
        '/weather_page': (BuildContext context) => const WeatherPage(),
        // '/message_test_page': (BuildContext context) => const MessageTestPage(),
        '/spending_display_page': (BuildContext context) => const SpendingDisplayPage(),

        // '/camera_test_page': (BuildContext context) =>  CameraTestPage(),
      },
    );
  }
}
// ===========================================================================================
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mobile Flutter App',
//       theme: CustomTheme.lightTheme,
//       home: const LoginPage(
//           title: 'CASA0015 Assessment'), // home:   MyHomePage(),
//       routes: {
//         '/home_page': (BuildContext context) => const MyHomePage(title: 'HomePage'),
//         '/first_page': (BuildContext context) => const FirstPage(),
//         '/map_test_page': (BuildContext context) => const MapTestPage(),
//         '/weather_page': (BuildContext context) => const WeatherPage(),
//         // '/camera_test_page': (BuildContext context) =>  CameraTestPage(),
//       },
//     );
//   }
// }

// -----------------------------------------------------------------------------------------------------
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mobile Flutter App',
//       theme: CustomTheme.lightTheme,
//       home: const MyHomePage(
//           title: 'CASA0015 Assessment'), // home:   MyHomePage(),
//       routes: {
//         '/first_page': (BuildContext context) => const FirstPage(),
//         '/map_test_page': (BuildContext context) => const MapTestPage(),
//         '/weather_page': (BuildContext context) => const WeatherPage(),
//         // '/camera_test_page': (BuildContext context) =>  CameraTestPage(),
//       },
//     );
//   }
// }
