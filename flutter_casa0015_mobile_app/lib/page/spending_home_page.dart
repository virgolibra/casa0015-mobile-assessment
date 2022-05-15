import 'package:flutter/material.dart';

import '../widgets.dart';

class SpendingHomePage extends StatefulWidget {
  const SpendingHomePage({Key? key}) : super(key: key);

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
        ElevatedButton(
          child: const Text('Spending'),
          onPressed: () {
            Navigator.pushNamed(context, '/spending_display_page');
            // Navigator.pop(context);
          },
        ),
        const Header("CASA0015 Assessment"),
        const Paragraph(
          'Mobile application development for casa0015-assessment',
        ),
      ],
    );
  }
}
