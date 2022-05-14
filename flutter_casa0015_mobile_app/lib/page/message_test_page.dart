import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';
import 'login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../authentication.dart';
import 'drawer_page.dart';

class MessageTestPage extends StatelessWidget {
  const MessageTestPage({Key? key, required this.email}) : super(key: key);
  final String email ;
  // Widget build(BuildContext context) {
  //   return Provider<Example>(
  //       create: (_) => Example(),
  //       // we use `builder` to obtain a new `BuildContext` that has access to the provider
  //       builder: (context) {
  //         // No longer throws
  //         return Text(context.watch<Example>()),
  //       }
  //   ),
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Page'),

      ),
      drawer: DrawerPage(email: email,),
      body: ListView(
        children: <Widget>[
          // Image.asset('assets/image1.jpg'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.account_balance_rounded, 'Money Tracker'),
          const Divider(
            height: 8,
            thickness: 2,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          Container(
              color: const Color(0xffE09E45),
              child: const IconAndDetail(
                  Icons.login_rounded, 'Message Test Page')),
          const Header('Discussion'),
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
                  addMessage: (message, type) =>
                      appState.addMessageToSpendingReport(message, type),
                  // messages: appState.spendingReportMessages,
                ),

                const Divider(
                  height: 8,
                  thickness: 2,
                  indent: 8,
                  endIndent: 8,
                  color: Colors.grey,
                ),
                // DisplaySpendingItem(
                //   messages: appState.spendingReportMessages,
                // ),
              ],
            ),
          ),
          const Divider(
            height: 8,
            thickness: 2,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          ElevatedButton(
            child: const Text('Spending'),
            onPressed: () {
              Navigator.pushNamed(context, '/spending_display_page');
              // Navigator.pop(context);
            },
          ),
          const Header("CASA0015 Assessment"),
          const Paragraph(
            'Mobile application development for casa0015-assessment',
          ),
        ],
      ),
    );
  }
}
