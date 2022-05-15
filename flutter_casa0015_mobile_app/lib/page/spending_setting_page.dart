import 'package:flutter/material.dart';

import '../widgets.dart';
import 'about_page.dart';
import 'login_page.dart';

class SpendingSettingPage extends StatefulWidget {
  const SpendingSettingPage({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  _SpendingSettingPageState createState() => _SpendingSettingPageState();
}

class _SpendingSettingPageState extends State<SpendingSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffDEC29B),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.email),
          ElevatedButton(
            child: const Text('Log Out'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text('About'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
