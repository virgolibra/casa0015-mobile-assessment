import 'package:flutter/material.dart';

import '../weather_display.dart';
import '../widgets.dart';

class SpendingHomePage extends StatefulWidget {
  const SpendingHomePage({Key? key, required this.lat, required this.lon}) : super(key: key);
  final double lat;
  final double lon;
  @override
  _SpendingHomePageState createState() => _SpendingHomePageState();
}

class _SpendingHomePageState extends State<SpendingHomePage> {


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // Image.asset('assets/image1.jpg'),
        const SizedBox(height: 8),
        const IconAndDetail(Icons.account_balance_rounded, 'Money Tracker'),
        const Divider(
          height: 8,
          thickness: 2,
          indent: 8,
          endIndent: 8,
          color: Colors.grey,
        ),
        Container(
            color: const Color(0xffE09E45),
            child: const IconAndDetail(
                Icons.login_rounded, 'Message Test Page')),
        const Header('Discussion'),

        const Divider(
          height: 8,
          thickness: 2,
          indent: 8,
          endIndent: 8,
          color: Colors.grey,
        ),
        WeatherDisplay(lat: widget.lat, lon: widget.lon,),
        const Header("CASA0015 Assessment"),
        const Paragraph(
          'Mobile application development for casa0015-assessment',
        ),
      ],
    );
  }
}
