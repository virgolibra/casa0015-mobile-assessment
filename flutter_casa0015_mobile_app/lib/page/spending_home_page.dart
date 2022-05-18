import 'package:flutter/material.dart';

import '../weather_display.dart';
import '../widgets.dart';

class SpendingHomePage extends StatefulWidget {
  const SpendingHomePage({Key? key, required this.lat, required this.lon})
      : super(key: key);
  final double lat;
  final double lon;
  @override
  _SpendingHomePageState createState() => _SpendingHomePageState();
}

class _SpendingHomePageState extends State<SpendingHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Image.asset('assets/image1.jpg'),
        const SizedBox(height: 8),
        const IconAndDetail(Icons.home_rounded, 'Home Page'),
        // const Divider(
        //   height: 8,
        //   thickness: 2,
        //   indent: 8,
        //   endIndent: 8,
        //   color: Color(0xffE09E45),
        // ),

        Expanded(
          child:
          Column(
            children: [
              WeatherDisplay(
                lat: widget.lat,
                lon: widget.lon,
              ),
            ],
          ),
        ),

        Image.asset('assets/click_to_add.png'),
      ],
    );
  }
}
