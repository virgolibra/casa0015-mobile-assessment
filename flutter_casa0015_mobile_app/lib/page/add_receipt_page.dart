import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_casa0015_mobile_app/page/login_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets.dart';

enum CaptureState {
  capturing,
  captured,
}

class AddReceiptPage extends StatefulWidget {
  const AddReceiptPage({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;
  @override
  _AddReceiptPageState createState() => _AddReceiptPageState();
}

class _AddReceiptPageState extends State<AddReceiptPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  late final Uint8List? data;
  late final String imageUrl;
  late XFile image;

  CaptureState captureState = CaptureState.capturing;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (captureState) {
      case CaptureState.capturing:
        return Scaffold(
          appBar: AppBar(title: const Text('Take a picture')),
          // You must wait until the controller is initialized before displaying the
          // camera preview. Use a FutureBuilder to display a loading spinner until the
          // controller has finished initializing.
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return CameraPreview(_controller);
                  } else {
                    // Otherwise, display a loading indicator.
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xff6D42CE),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    // Take the Picture in a try / catch block. If anything goes wrong,
                    // catch the error.
                    try {
                      // Ensure that the camera is initialized.
                      await _initializeControllerFuture;
                      // Attempt to take a picture and get the file `image`
                      // where it was saved.
                      image = await _controller.takePicture();
                      setState(() {
                        captureState = CaptureState.captured;
                      });
                    } catch (e) {
                      // If an error occurs, log the error to the console.
                      print(e);
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.camera_rounded,
                        color: Color(0xffF5E0C3),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Click to Capture',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffF5E0C3),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case CaptureState.captured:
        return DisplayPictureScreen(imagePath: image.path);
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }
}

class ImageData {
  late String imagePath;
  late bool receiptStatus;

  ImageData(String imagePath, bool receiptStatus) {
    this.imagePath = imagePath;
    this.receiptStatus = receiptStatus;
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late ImageData imageData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageData = ImageData(widget.imagePath, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const IconAndDetail(Icons.photo_rounded, 'Captured Photo Preview'),
          Image.file(File(widget.imagePath)),
          // Text(
          //   'Path: ${widget.imagePath}',
          //   style: TextStyle(
          //     fontSize: 15,
          //   ),
          // ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            child: const Text('Continue'),
            style: ElevatedButton.styleFrom(
                primary: const Color(0xff6D42CE),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onPressed: () {
              imageData.receiptStatus = true;
              Navigator.of(context).pop(imageData);
            },
          ),
        ],
      ),
    );
  }
}
