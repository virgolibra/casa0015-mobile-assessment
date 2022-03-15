import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(51.5079116,-0.1324752);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MONEY TRACKER'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 13.0,
        ),
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
