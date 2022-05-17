import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';
import 'login_page.dart';
import 'drawer_page.dart';
import 'package:geolocator/geolocator.dart';

class SpendingAddPage extends StatefulWidget {
  const SpendingAddPage({Key? key}) : super(key: key);

  @override
  _SpendingAddPageState createState() => _SpendingAddPageState();
}

class _SpendingAddPageState extends State<SpendingAddPage> {
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

  List<String> iconsListDescription = [
    'General',
    'Bills',
    'Eating out',
    'Delivery',
    'Entertainment',
    'Gifts',
    'Groceries',
    'Travel',
    'Shopping',
    'Transport',
    'Personal care',
    'Pets',
  ];

  int buttonOnPressed = 0;
  double? autoLat, autoLon;

  // int iconDescriptionIndex
  @override
  void initState() {
    super.initState();
    // ws = new WeatherFactory(key);
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    log("sdsddssssssssss $position");

    // List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      // _userCurrentPosition = LatLng(position.latitude, position.longitude);
      // print('${placemark[0].name}');

      autoLat = position.latitude;
      autoLon = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffDEC29B),
      child: ListView(
        children: <Widget>[
          // Image.asset('assets/image1.jpg'),
          const SizedBox(height: 4),
          // const IconAndDetail(Icons.category_rounded, 'Select a category'),
          Container(
            child: Text('Select a category'),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: const Color(0xffC9A87C),
                borderRadius: BorderRadius.circular(8)),
          ),
          // Container(
          //     color: const Color(0xffE09E45),
          //     child: const IconAndDetail(
          //         Icons.login_rounded, 'Message Test Page')),
          // const Header('Discussion'),

          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: const Color(0xffC9A87C),
                borderRadius: BorderRadius.circular(18)),
            child: Column(
              children: [
                // Container(
                //   child: Text(iconsListDescription[buttonOnPressed]),
                //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //   decoration: BoxDecoration(
                //       color: const Color(0xffC9A87C),
                //       borderRadius: BorderRadius.circular(8)),
                // ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  iconsListDescription[buttonOnPressed],
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xffF5E0C3),
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 120,
                  padding: EdgeInsets.all(4),
                  // decoration: BoxDecoration(
                  //     color: const Color(0xffC9A87C),
                  //     borderRadius: BorderRadius.circular(10)),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 50,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemCount: iconsList.length,
                    // crossAxisSpacing: 10,
                    // mainAxisSpacing: 10,
                    // crossAxisCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return IconButton(
                        iconSize: 40,
                        highlightColor: Colors.red,
                        // color: const Color(0xff5D4524),
                        onPressed: () {
                          setState(() {
                            buttonOnPressed = index;
                            // iconDescriptionIndex = index;
                          });
                        },
                        icon: Icon(iconsList[index]),
                        color: (buttonOnPressed == index)
                            ? Color(0xff936F3E)
                            : Color(0xffF5E0C3),
                      );
                    },
                  ),
                )
              ],
            ),
          ),

          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SpendingReport(
                //   addMessage: (message, type) =>
                //       appState.addMessageToSpendingReport(message, type),
                //   messages: appState.spendingReportMessages,
                // ),
                AddSpendingItem(
                  addItem: (item, price) => appState.addMessageToSpendingReport(
                      item,
                      price,
                      iconsListDescription[buttonOnPressed],
                      buttonOnPressed,
                      autoLat!,
                      autoLon!),

                  // messages: appState.spendingReportMessages,
                ),

                const Divider(
                  height: 8,
                  thickness: 2,
                  indent: 8,
                  endIndent: 8,
                  color: Color(0xff936F3E),
                ),
                // DisplaySpendingItem(
                //   messages: appState.spendingReportMessages,
                // ),
              ],
            ),
          ),
          //
          // Text(
          //   'Lat: $autoLat',
          //   style: TextStyle(fontSize: 15),
          // ),
          // Text(
          //   'Lon: $autoLon',
          //   style: TextStyle(fontSize: 15),
          // ),
          // const Divider(
          //   height: 8,
          //   thickness: 2,
          //   indent: 8,
          //   endIndent: 8,
          //   color: Colors.grey,
          // ),
          // ElevatedButton(
          //   child: const Text('Spending'),
          //   onPressed: () {
          //     Navigator.pushNamed(context, '/spending_display_page');
          //     // Navigator.pop(context);
          //   },
          // ),
          //
          // const Header("CASA0015 Assessment"),
          // const Paragraph(
          //   'Mobile application development for casa0015-assessment',
          // ),
        ],
      ),
    );
  }
}
