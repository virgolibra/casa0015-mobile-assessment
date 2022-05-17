import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

    downloadImage();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> downloadImage() async {
    final storageRef = FirebaseStorage.instance.ref();
    final islandRef = storageRef.child(
        "images/spendingReport/H731NtAnbnPrhB02ZDj585bb9Ma2/CAP638979139413938825.jpg");

    try {
      imageUrl = await storageRef
          .child(
              "images/spendingReport/H731NtAnbnPrhB02ZDj585bb9Ma2/CAP638979139413938825.jpg")
          .getDownloadURL();
      log(imageUrl);
    } on FirebaseException catch (e) {
      // Handle any errors.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
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
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,

                  imageUrl: imageUrl,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  final String imageUrl;
  const DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.imageUrl})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void uploadImage() {
    final storage = FirebaseStorage.instance;
    File file = File(widget.imagePath);

    final imageName =
        widget.imagePath.substring(widget.imagePath.lastIndexOf('/'));

    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

// Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
    final uploadTask = storageRef
        .child(
            'images/spendingReport/${FirebaseAuth.instance.currentUser?.uid}/$imageName')
        .putFile(file, metadata);
    // Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          // ...
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: ListView(
        children: [
          Image.file(File(widget.imagePath)),
          Text(
            'Path: ${widget.imagePath}',
            style: TextStyle(fontSize: 15),
          ),
          ElevatedButton(
            child: const Text('Upload Image'),
            onPressed: () {
              uploadImage();
            },
          ),
          ElevatedButton(
            child: const Text('Continue'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: Image(image: NetworkImage(widget.imageUrl)),
          ),
        ],
      ),
    );
  }
}
