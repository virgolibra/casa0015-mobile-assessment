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

import '../widgets.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage(
      {Key? key,
      required this.id,
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
  final String id;
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
        '${dateTime!.day.toString()} ${DateFormat('MMMM').format(dateTime!)} ${dateTime!.year.toString()}';
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
    // log("placemarks $placemarks");

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
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Image(image: NetworkImage(imageUrl!)),
        ),
      ],
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

  Future<void> deleteMessageToSpendingReport() {
    return FirebaseFirestore.instance
        .collection('SpendingReport')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc(widget.id)
        .delete();
  }

  Future<bool?> showAddItemDoneDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Press Yes to remove this item."),
          content: const Text("Item will be permanently deleted.",style: TextStyle(color: Colors.red,fontSize: 15),),

          actions: <Widget>[
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(color: Colors.black87,fontSize: 20),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),

            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.red,fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
                setState(() {

                });
              },
            ),
            // TextButton(
            //   child: Text("delete"),
            //   onPressed: () {
            //     Navigator.of(context).pop(true);
            //   },
            // ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(widget.lat, widget.lon),
        infoWindow: InfoWindow(title: widget.item)));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Color(0xffF5E0C3),
      body: ListView(
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                  color: const Color(0xffDEC29B),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                // physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                    height: 1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Item Detail',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              formattedDateTime!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 8,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.black87,
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
                  Text('Somewhere in ${_address!}'),
                  const Divider(
                    height: 8,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.black87,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Icon(
                          iconsList[widget.iconIndex],
                          size: 80,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '£',
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              widget.price,
                              style: const TextStyle(
                                  fontSize: 45,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 130,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 30,
                          child: ListTile(
                            leading: const Icon(
                                Icons.drive_file_rename_outline_rounded),
                            minLeadingWidth: 2,
                            title: const Text('Item'),
                            selected: false,
                            trailing: Text(
                              widget.item,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: ListTile(
                            leading: const Icon(
                              Icons.category_rounded,
                            ),
                            minLeadingWidth: 2,
                            title: const Text('Category'),
                            selected: false,
                            trailing: Text(
                              widget.category,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: ListTile(
                            leading: const Icon(Icons.punch_clock_rounded),
                            minLeadingWidth: 2,
                            title: const Text('Time Added'),
                            selected: false,
                            trailing: Text(
                              time!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: ListTile(
                            leading: const Icon(Icons.date_range_rounded),
                            minLeadingWidth: 2,
                            title: const Text('Date Added'),
                            selected: false,
                            trailing: Text(
                              date!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 8,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.black87,
                  ),
                  // Text(widget.item, style: TextStyle(fontSize: 18),),
                  //
                  // Text(_address!),
                  // Text(widget.item),
                  // Text(widget.price),
                  // Text(widget.category),
                  // Text(widget.iconIndex.toString()),
                  // Text('$time  $date  $weekday'),
                  // Text(formattedDateTime!),
                  // Text(widget.imageId),
                  // Text(widget.isReceiptUpload.toString()),
                  const IconAndDetail(Icons.receipt_rounded, 'Receipt'),
                  widget.isReceiptUpload == true
                      ? _resultView()
                      : const Text(
                          'No receipt upload',
                          style: TextStyle(fontSize: 16),
                        ),
                  const Divider(
                    height: 8,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.black87,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xffE09E45),
                          side: const BorderSide(
                              color: Color(0xffE09E45), width: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        // await showAddItemDoneDialog();

                        var isTrue = await showAddItemDoneDialog();
                        if (isTrue!) {
                          deleteMessageToSpendingReport();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.remove_circle_outline_rounded,
                            color: Color(0xffF5E0C3),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Remove Item',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffF5E0C3),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
