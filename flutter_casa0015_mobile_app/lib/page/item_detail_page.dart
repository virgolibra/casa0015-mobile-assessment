import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage(
      {Key? key, required this.lat, required this.lon, required this.item})
      : super(key: key);
  final double lat;
  final double lon;
  final String item;

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late GoogleMapController mapController;
  final List<Marker> _markers = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    //
    // _markers.add( Marker(
    //     markerId: const MarkerId('SomeId2'),
    //     position: _userCurrentPosition,
    //     infoWindow: const InfoWindow(title: 'Current Location')));
  }

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(widget.lat, widget.lon),
        infoWindow: InfoWindow(title: widget.item)));
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
                target: LatLng(widget.lat, widget.lon),
                zoom: 13.0,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapToolbarEnabled: false,
              markers: Set<Marker>.of(_markers),
            ),
          ),
          // ElevatedButton(
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          //           (Set<MaterialState> states) {
          //         if (states.contains(MaterialState.pressed)) {
          //           return Theme.of(context)
          //               .colorScheme
          //               .primary
          //               .withOpacity(0.5);
          //         }
          //         return null; // Use the component's default.
          //       },
          //     ),
          //   ),
          //   onPressed: () {
          //     _getUserLocation();
          //     mapController.moveCamera( CameraUpdate.newCameraPosition(
          //         CameraPosition(target: _userCurrentPosition, zoom: 13)
          //       //17 is new zoom level
          //     ));
          //
          //     setState(() {
          //       _markers.add( Marker(
          //           markerId: const MarkerId('SomeId2'),
          //           position: _userCurrentPosition,
          //           infoWindow: const InfoWindow(title: 'Magic Location')));
          //     });
          //   },
          //   child: const Text('My location'),
          // ),
        ],
      ),

    );
  }
}
