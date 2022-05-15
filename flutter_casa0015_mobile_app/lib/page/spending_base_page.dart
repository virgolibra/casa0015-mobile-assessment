import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_add_page.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_display_page.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_home_page.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_setting_page.dart';
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
          SpendingHomePage(),
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

//===================================================================

// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../widgets.dart';
// import 'login_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import '../firebase_options.dart';
// import '../authentication.dart';
// import 'drawer_page.dart';
// import 'package:bottom_bar/bottom_bar.dart';
//
// class MessageTestPage extends StatefulWidget {
//   const MessageTestPage({Key? key, required this.email}) : super(key: key);
//   final String email ;
//
//   @override
//   State<MessageTestPage> createState() => _MessageTestPageState();
// }
//
// class _MessageTestPageState extends State<MessageTestPage> {
//   int _currentPage = 0;
//   final _pageController = PageController();
//
//   // Widget build(BuildContext context) {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Message Page'),
//
//       ),
//       drawer: DrawerPage(email: widget.email,),
//       body: ListView(
//         children: <Widget>[
//           // Image.asset('assets/image1.jpg'),
//           const SizedBox(height: 8),
//           const IconAndDetail(Icons.account_balance_rounded, 'Money Tracker'),
//           const Divider(
//             height: 8,
//             thickness: 2,
//             indent: 8,
//             endIndent: 8,
//             color: Colors.grey,
//           ),
//           Container(
//               color: const Color(0xffE09E45),
//               child: const IconAndDetail(
//                   Icons.login_rounded, 'Message Test Page')),
//           const Header('Discussion'),
//           Consumer<ApplicationState>(
//             builder: (context, appState, _) => Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // SpendingReport(
//                 //   addMessage: (message, type) =>
//                 //       appState.addMessageToSpendingReport(message, type),
//                 //   messages: appState.spendingReportMessages,
//                 // ),
//                 AddSpendingItem(
//                   addMessage: (message, type) =>
//                       appState.addMessageToSpendingReport(message, type),
//                   // messages: appState.spendingReportMessages,
//                 ),
//
//                 const Divider(
//                   height: 8,
//                   thickness: 2,
//                   indent: 8,
//                   endIndent: 8,
//                   color: Colors.grey,
//                 ),
//                 // DisplaySpendingItem(
//                 //   messages: appState.spendingReportMessages,
//                 // ),
//               ],
//             ),
//           ),
//           const Divider(
//             height: 8,
//             thickness: 2,
//             indent: 8,
//             endIndent: 8,
//             color: Colors.grey,
//           ),
//           ElevatedButton(
//             child: const Text('Spending'),
//             onPressed: () {
//               Navigator.pushNamed(context, '/spending_display_page');
//               // Navigator.pop(context);
//             },
//           ),
//           const Header("CASA0015 Assessment"),
//           const Paragraph(
//             'Mobile application development for casa0015-assessment',
//           ),
//         ],
//       ),
//
//       bottomNavigationBar: ConvexAppBar(
//         style: TabStyle.react,
//         backgroundColor: const Color(0xffEDD5B3),
//         activeColor: const Color(0xfffff5E0),
//         color: const Color(0xffC9A87C),
//         items: const [
//           TabItem(icon: Icons.home_filled),
//           TabItem(icon: Icons.workspaces),
//           TabItem(icon: Icons.person),
//         ],
//         initialActiveIndex: _selectedIndex,
//
//         // onTap: (int i) => print('click index=$i'),
//         onTap: (int i) {
//           print('click index=$i');
//           switch (i) {
//             case 0:
//               // Navigator.pop(context);
//               break;
//             case 1:
//               // Navigator.pop(context);
//               Navigator.pushNamed(context, '/spending_display_page');
//               setState(() {
//                 _selectedIndex = 0;
//               });
//
//               break;
//             case 2:
//
//               break;
//
//             default:
//               break;
//           }
//         },
//       ),
//     );
//
//
//   }
// }
