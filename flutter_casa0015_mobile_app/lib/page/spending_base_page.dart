import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_add_page.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_display_page.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_home_page.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_setting_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';
import 'login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../authentication.dart';
import 'drawer_page.dart';
import 'package:bottom_bar/bottom_bar.dart';

class SpendingBasePage extends StatefulWidget {
  const SpendingBasePage({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<SpendingBasePage> createState() => _SpendingBasePage();
}

class _SpendingBasePage extends State<SpendingBasePage> {
  int _currentPage = 0;
  final _pageController = PageController();

  double? autoLat, autoLon;
  @override
  void initState() {
    super.initState();
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

    // await Future.delayed(Duration(milliseconds: 1000), () {});
  }
  // Widget build(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDEC29B),
      appBar: AppBar(
        title: const Text('Money Tracker'),
      ),
      drawer: DrawerPage(
        email: widget.email,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          SpendingHomePage(lat: autoLat!, lon: autoLon!,),
          // Container(color: Colors.greenAccent.shade700),
          // Container(color: Colors.orange),
          SpendingAddPage(),
          SpendingDisplayPage(),
          SpendingSettingPage(email: widget.email),
        ],
        onPageChanged: (index) {
          // Use a better state management solution
          // setState is used for simplicity
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        backgroundColor: const Color(0xffF5E0C3),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Color(0xff936F3E),
          ),
          BottomBarItem(
            icon: Icon(Icons.add_box_rounded),
            title: Text('Add Item'),
            activeColor: Color(0xff936F3E),
          ),
          BottomBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            title: Text('Transaction'),
            activeColor: Color(0xff936F3E),
          ),
          BottomBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Color(0xff936F3E),
          ),
        ],
      ),
    );
  }
}
