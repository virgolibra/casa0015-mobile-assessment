import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SizedBox(
          width: 100,
          height: 350,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                    child: const Text('Test Button'), onPressed: () async {}),
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5);
                        }
                        return null; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home_page');
                  },
                  child: const Text('MainPage'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
