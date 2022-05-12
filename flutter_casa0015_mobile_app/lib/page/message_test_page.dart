import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../authentication.dart';
import 'login_page.dart';

class MessageTestPage extends StatelessWidget {
  const MessageTestPage({Key? key}) : super(key: key);

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
      body: ListView(
        children: <Widget>[
          Image.asset('assets/image1.jpg'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.account_balance_rounded, 'Money Tracker'),
          const Divider(
            height: 8,
            thickness: 2,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const IconAndDetail(Icons.login_rounded, 'Message Test Page'),
          const Header('Discussion'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpendingReport(
                  addMessage: (message) =>
                      appState.addMessageToSpendingReport(message),
                  messages: appState.spendingReportMessages,
                ),
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
          const Header("CASA0015 Assessment"),
          const Paragraph(
            'Mobile application development for casa0015-assessment',
          ),
        ],
      ),
    );
  }
}

// class SpendingReport extends StatefulWidget {
//   const SpendingReport({required this.addMessage, required this.messages});
//   final FutureOr<void> Function(String message) addMessage;
//   final List<SpendingReportMessage> messages; // new
//
//   @override
//   _SpendingReportState createState() => _SpendingReportState();
// }
//
// class _SpendingReportState extends State<SpendingReport> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_SpendingReportState');
//   final _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _formKey,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       hintText: 'Leave a message',
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Enter your message to continue';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 StyledButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await widget.addMessage(_controller.text);
//                       _controller.clear();
//                     }
//                   },
//                   child: Row(
//                     children: const [
//                       Icon(Icons.send),
//                       SizedBox(width: 4),
//                       Text('SEND'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         for (var message in widget.messages)
//           Paragraph('${message.name}: ${message.message}'),
//         const SizedBox(height: 8),
//       ],
//     );
//   }
// }
