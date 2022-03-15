import 'package:flutter/material.dart';
import 'first_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                child: const Text('First Page'), onPressed: () async {}),
            ElevatedButton(
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
                Navigator.pushNamed(context, '/first_page');
              },
              child: const Text('Settings'),
            ),
            ElevatedButton(
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
              onPressed: () {},
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}
