import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }



class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage(
      {Key? key,
      required this.lat,
      required this.lon,
      required this.item,
      required this.iconIndex,
      required this.category,
      required this.price,
      required this.timestamp,
      required this.isReceiptUpload,
      required this.imageId})
      : super(key: key);
  final double lat;
  final double lon;
  final String item;
  final int iconIndex;
  final String category;
  final String price;
  final int timestamp;
  final bool isReceiptUpload;
  final String imageId;

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {

  AppState _state = AppState.NOT_DOWNLOADED;

  late GoogleMapController mapController;
  final List<Marker> _markers = [];
  String? _name;
  String? _street;
  String? _thoroughfare;
  String? _subAdministrativeArea;
  String? _administrativeArea;
  String? _postalCode;
  String? _address;

  List<IconData> iconsList = [
    Icons.widgets_rounded, // General
    Icons.receipt_rounded, // Bills
    Icons.restaurant_rounded, // Eating out
    Icons.delivery_dining_rounded, // Delivery
    Icons.emoji_emotions_rounded, // Entertainment
    Icons.card_giftcard_rounded, // Gifts
    Icons.store_rounded, // Groceries
    Icons.airplanemode_active_rounded, // Travel
    Icons.shopping_cart_rounded, // Shopping
    Icons.directions_bus_rounded, // Transport
    Icons.favorite_rounded, // Personal care
    Icons.pets_rounded, // Pets
  ];

  DateTime? dateTime;
  String? date;
  String? time;
  String? weekday;
  String? formattedDateTime;

  late final Uint8List? data;
  late final String? imageUrl;
  late XFile image;

  @override
  void initState() {
    // TODO: implement initState
    _getAddress();
    dateTime = DateTime.fromMillisecondsSinceEpoch(widget.timestamp);

    formattedDateTime =
        DateFormat('E  dd MMMM yyyy  HH:mm:ss').format(dateTime!);

    date =
        '${dateTime!.day.toString()}/${dateTime!.month.toString()}/${dateTime!.year.toString()}';
    time =
        '${dateTime!.hour.toString()}:${dateTime!.minute.toString()}:${dateTime!.second.toString()}';
    weekday = DateFormat('EEEE').format(dateTime!);

    // if (widget.isReceiptUpload){
    //   downloadImage();
    // }

    downloadImage();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    //
    // _markers.add( Marker(
    //     markerId: const MarkerId('SomeId2'),
    //     position: _userCurrentPosition,
    //     infoWindow: const InfoWindow(title: 'Current Location')));
  }

  void _getAddress() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.lat, widget.lon);
    log("placemarks $placemarks");

    // List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _name = placemarks[0].name;
      _street = placemarks[0].street;
      _thoroughfare = placemarks[0].thoroughfare;
      _subAdministrativeArea = placemarks[0].subAdministrativeArea;
      _administrativeArea = placemarks[0].administrativeArea;
      _postalCode = placemarks[0].postalCode;

      _address =
          '$_name, $_street, $_thoroughfare, $_subAdministrativeArea, $_administrativeArea, $_postalCode';
      // print('${placemark[0].name}');
    });
  }

  Future<void> downloadImage() async {
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    final storageRef = FirebaseStorage.instance.ref();
    final islandRef = storageRef.child(
        "images/spendingReport/H731NtAnbnPrhB02ZDj585bb9Ma2/CAP638979139413938825.jpg");

    try {
      imageUrl = await storageRef
          .child(
          'images/spendingReport/${FirebaseAuth.instance.currentUser?.uid}${widget.imageId}')
          .getDownloadURL();
      log('22222222222222222222222222222222$imageUrl!');

      setState(() {
        _state = AppState.FINISHED_DOWNLOADING;
      });

    } on FirebaseException catch (e) {
      // Handle any errors.
    }
  }

  Widget contentFinishedDownload() {
    return Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: Image(image: NetworkImage(imageUrl!)),
      )
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(children: [
        Text(
          'Fetching Image...',
          style: TextStyle(fontSize: 20),
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Wait for starting downloading',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
      ? contentDownloading()
      : contentNotDownloaded();

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(widget.lat, widget.lon),
        infoWindow: InfoWindow(title: widget.item)));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          formattedDateTime!,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Color(0xffF5E0C3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              liteModeEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat, widget.lon),
                zoom: 13.0,
              ),
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              mapToolbarEnabled: false,
              markers: Set<Marker>.of(_markers),
            ),
          ),
          Icon(
            iconsList[widget.iconIndex],
            size: 50,
          ),
          Text(_address!),
          Text(widget.item),
          Text(widget.price),
          Text(widget.category),
          Text(widget.iconIndex.toString()),
          Text('$time  $date  $weekday'),
          Text(formattedDateTime!),
          Text(widget.imageId),
          Text(widget.isReceiptUpload.toString()),

          widget.isReceiptUpload == true
              ?   _resultView()
              : const Text(
            'No receipt',
            style: TextStyle(fontSize: 16),
          ),


        ],
      ),
    );
  }
}
