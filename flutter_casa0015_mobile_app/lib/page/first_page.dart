import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(51.5079116, -0.1324752);
  late LatLng _userCurrentPosition;
  final List<Marker> _markers = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getUserLocation();
    //
    // _markers.add( Marker(
    //     markerId: const MarkerId('SomeId2'),
    //     position: _userCurrentPosition,
    //     infoWindow: const InfoWindow(title: 'Current Location')));
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    log("sdsddssssssssss $position");

    // List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _userCurrentPosition = LatLng(position.latitude, position.longitude);
      // print('${placemark[0].name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    _markers.add(const Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(51.5079116, -0.1324752),
        infoWindow: InfoWindow(title: 'The title of the marker')));
    // var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('MONEY TRACKER'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 400,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 13.0,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapToolbarEnabled: false,
              markers: Set<Marker>.of(_markers),
            ),
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
            onPressed: () {
              _getUserLocation();
              mapController.moveCamera( CameraUpdate.newCameraPosition(
                  CameraPosition(target: _userCurrentPosition, zoom: 13)
                //17 is new zoom level
              ));

              setState(() {
                _markers.add( Marker(
                    markerId: const MarkerId('SomeId2'),
                    position: _userCurrentPosition,
                    infoWindow: const InfoWindow(title: 'Magic Location')));
              });
            },
            child: const Text('My location'),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: const Color(0xffEDD5B3),
        activeColor: const Color(0xfffff5E0),
        color: const Color(0xffC9A87C),
        items: const [
          TabItem(icon: Icons.home_filled),
          TabItem(icon: Icons.workspaces),
          TabItem(icon: Icons.person),
        ],
        initialActiveIndex: 1,
        // onTap: (int i) => print('click index=$i'),
        onTap: (int i) {
          print('click index=$i');
          switch (i) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              break;
            case 2:
              Navigator.pushNamed(context, '/second_page');
              break;

            default:
              break;
          }
        },
      ),
    );
  }
}
