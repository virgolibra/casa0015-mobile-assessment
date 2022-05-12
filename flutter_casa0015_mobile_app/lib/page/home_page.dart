import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera_test_page.dart';

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
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
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
                    child: const Text('First Page'), onPressed: () async {}),
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
                    Navigator.pushNamed(context, '/weather_page');
                  },
                  child: const Text('Weather'),
                ),
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
                  // onPressed: () {
                  //   Navigator.pushNamed(context, '/camera_test_page');
                  // },

                  onPressed: () async {
                    try {
                      WidgetsFlutterBinding.ensureInitialized();
                      // Obtain a list of the available cameras on the device.
                      final cameras = await availableCameras();
                      // Get a specific camera from the list of available cameras.
                      final firstCamera = cameras.first;

                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CameraTestPage(
                            camera: firstCamera,
                          ),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Camera'),
                ),
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
                    Navigator.pushNamed(context, '/first_page');
                  },
                  child: const Text('Settings'),
                ),
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
                    Navigator.pushNamed(context, '/map_test_page');
                  },
                  child: const Text('About'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
