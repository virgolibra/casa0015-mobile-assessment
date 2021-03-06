import 'package:flutter/material.dart';
import 'package:flutter_casa0015_mobile_app/page/login_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigateToHome();

  }
  _navigateToHome()async {
    await Future.delayed(Duration(milliseconds: 500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              height: 30,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color(0xffC9A87C),
                  borderRadius: BorderRadius.circular(10)),

            ),
            Container(
              child: Text(
                "Loading...",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


