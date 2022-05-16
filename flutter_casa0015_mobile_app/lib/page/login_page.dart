import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_base_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';
import '../authentication.dart';
import '../widgets.dart';

import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Tracker'),
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
          const IconAndDetail(
              Icons.login_rounded, 'Log in to access Money Tracker'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Authentication(
              email: appState.email,
              loginState: appState.loginState,
              startLoginFlow: appState.startLoginFlow,
              endLoginFlow: appState.endLoginFlow,
              verifyEmail: appState.verifyEmail,
              signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
              cancelRegistration: appState.cancelRegistration,
              registerAccount: appState.registerAccount,
              signOut: appState.signOut,
            ),
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Add from here
                // if (appState.attendees >= 2)
                //   Paragraph('${appState.attendees} people going')
                // else if (appState.attendees == 1)
                //   const Paragraph('1 person going')
                // else
                //   const Paragraph('No one going'),
                // To here.
                if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                  // Add from here
                  // YesNoSelection(
                  //   state: appState.attending,
                  //   onSelection: (attending) => appState.attending = attending,
                  // ),
                  // To here.
                  // const Header('Discussion'),
                  // GuestBook(
                  //   addMessage: (message) =>
                  //       appState.addMessageToGuestBook(message),
                  //   messages: appState.guestBookMessages,
                  // ),
                  StartHome(
                    title: 'TestStartHome',
                    email: appState.email!,
                  ),
                ],
              ],
            ),
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

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Firebase Meetup'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Image.asset('assets/image1.jpg'),
//           const SizedBox(height: 8),
//           const IconAndDetail(Icons.account_balance_rounded , 'Money Tracker'),
//           const IconAndDetail(Icons.location_city, 'San Francisco'),
//           Consumer<ApplicationState>(
//             builder: (context, appState, _) => Authentication(
//               email: appState.email,
//               loginState: appState.loginState,
//               startLoginFlow: appState.startLoginFlow,
//               verifyEmail: appState.verifyEmail,
//               signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
//               cancelRegistration: appState.cancelRegistration,
//               registerAccount: appState.registerAccount,
//               signOut: appState.signOut,
//             ),
//           ),
//           const Divider(
//             height: 8,
//             thickness: 1,
//             indent: 8,
//             endIndent: 8,
//             color: Colors.grey,
//           ),
//           const Header("What we'll be doing"),
//           const Paragraph(
//             'Join us for a day full of Firebase Workshops and Pizza!',
//           ),
//           Consumer<ApplicationState>(
//             builder: (context, appState, _) => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Add from here
//                 if (appState.attendees >= 2)
//                   Paragraph('${appState.attendees} people going')
//                 else if (appState.attendees == 1)
//                   const Paragraph('1 person going')
//                 else
//                   const Paragraph('No one going'),
//                 // To here.
//                 if (appState.loginState == ApplicationLoginState.loggedIn) ...[
//                   // Add from here
//                   YesNoSelection(
//                     state: appState.attending,
//                     onSelection: (attending) => appState.attending = attending,
//                   ),
//                   // To here.
//                   const Header('Discussion'),
//                   // GuestBook(
//                   //   addMessage: (message) =>
//                   //       appState.addMessageToGuestBook(message),
//                   //   messages: appState.guestBookMessages,
//                   // ),
//                   const StartHome(title: 'TestStartHome',),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SpendingReportMessage {
  SpendingReportMessage({
    required this.name,
    required this.price,
    required this.item,
    required this.category,
    required this.iconIndex,
  });
  final String name;
  final String price;
  final String item;
  final String category;
  final int iconIndex;
  // final Timestamp timestamp;
}

enum Attending { yes, no, unknown }

// class SpendingReport extends StatefulWidget {
//   const SpendingReport({required this.addMessage, required this.messages});
//   final FutureOr<void> Function(String message, String type) addMessage;
//   final List<SpendingReportMessage> messages; // new
//
//   @override
//   _SpendingReportState createState() => _SpendingReportState();
// }
//
// class _SpendingReportState extends State<SpendingReport> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_SpendingReportState');
//   final _controller = TextEditingController();
//   final _controller2 = TextEditingController();
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
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 20,
//                       width: 200,
//                       child: TextFormField(
//                         controller: _controller,
//                         decoration: const InputDecoration(
//                           hintText: 'Leave a message',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Enter your message to continue';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 200,
//                       child: TextFormField(
//                         controller: _controller2,
//                         decoration: const InputDecoration(
//                           hintText: 'A fake text Field',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Enter your message to continue';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 8),
//                 StyledButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await widget.addMessage(
//                           _controller.text, _controller2.text);
//                       _controller.clear();
//                       _controller2.clear();
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
//         // ------MESSAGE display ----------------------------------
//         //
//         // SizedBox(
//         //   height: 300,
//         //   child: StickyGroupedListView(
//         //     elements: widget.messages,
//         //     groupBy: (SpendingReportMessage message) => DateTime(
//         //         DateTime.fromMicrosecondsSinceEpoch(message.timestamp.millisecondsSinceEpoch).year,
//         //         DateTime.fromMicrosecondsSinceEpoch(message.timestamp.millisecondsSinceEpoch).month,
//         //         DateTime.fromMicrosecondsSinceEpoch(message.timestamp.millisecondsSinceEpoch).day),
//         //     groupSeparatorBuilder: (SpendingReportMessage message) => Container(
//         //       height: 50,
//         //       child: Align(
//         //         alignment: Alignment.center,
//         //         child: Container(
//         //           width: 120,
//         //           decoration: BoxDecoration(
//         //             color: Colors.blue[300],
//         //             border: Border.all(
//         //               color: Colors.blue[300]!,
//         //             ),
//         //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
//         //           ),
//         //           child: Padding(
//         //             padding: const EdgeInsets.all(8.0),
//         //             child: Text(
//         //               '${DateTime.fromMicrosecondsSinceEpoch(message.timestamp.millisecondsSinceEpoch).day}. ${DateTime.fromMicrosecondsSinceEpoch(message.timestamp.millisecondsSinceEpoch).month}, ${DateTime.fromMicrosecondsSinceEpoch(message.timestamp.millisecondsSinceEpoch).year}',
//         //               textAlign: TextAlign.center,
//         //             ),
//         //           ),
//         //         ),
//         //       ),
//         //     ),
//         //     itemBuilder: (_, SpendingReportMessage message) {
//         //       return Card(
//         //         shape: RoundedRectangleBorder(
//         //           borderRadius: BorderRadius.circular(6.0),
//         //         ),
//         //         elevation: 8.0,
//         //         margin:
//         //             new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//         //         child: Container(
//         //           child: ListTile(
//         //             contentPadding:
//         //                 EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         //             leading: Icon(Icons.account_balance),
//         //             title: Text(message.name),
//         //             subtitle: Text(message.type),
//         //             // trailing: Text('${message.timestamp.toDate().hour}:00'),
//         //             trailing: Text(
//         //                 '${DateTime.fromMicrosecondsSinceEpoch(message.timestamp.millisecondsSinceEpoch).hour}:00'),
//         //           ),
//         //         ),
//         //       );
//         //     },
//         //   ),
//         // ),
//         //========================================================
//         ConstrainedBox(
//           constraints: const BoxConstraints(
//             maxHeight: 350,
//           ),
//           child: ListView.builder(
//             padding: const EdgeInsets.all(8),
//             itemCount: widget.messages.length,
//             shrinkWrap: false,
//             // addAutomaticKeepAlives: false,
//             // addSemanticIndexes: true,
//             // semanticChildCount: 3,
//
//             itemBuilder: (BuildContext context, int index) {
//               return ListElement(
//                   text: widget.messages[index].name,
//                   subText: widget.messages[index].message,
//               price: widget.messages[index].type,);
//             },
//             // children: <Widget>[
//             //   for (var message in widget.messages)
//             //   // Paragraph('${message.name}: ${message.message}: ${message.type}'),
//             //     ListElement(message.name, message.message),
//             // ],
//           ),
//         ),
//
//         const SizedBox(height: 8),
//       ],
//     );
//   }
// }

class AddSpendingItem extends StatefulWidget {
  const AddSpendingItem({Key? key, required this.addItem}) : super(key: key);
  final FutureOr<void> Function(String item, String price) addItem;

  @override
  _AddSpendingItemState createState() => _AddSpendingItemState();
}

class _AddSpendingItemState extends State<AddSpendingItem> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_AddSpendingItemState');
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text('Item Description'),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: const Color(0xffC9A87C),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Add an item description',
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter item description to continue';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controller2,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixText: '£ ',
                      labelText: 'Amount',
                      labelStyle: TextStyle(fontSize: 20),
                      floatingLabelStyle:
                          TextStyle(color: Color(0xff936F3E), fontSize: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the amount';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: StyledButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await widget.addItem(_controller.text, _controller2.text);
                        _controller.clear();
                        _controller2.clear();
                      }
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.add_circle_rounded),
                        SizedBox(width: 10),
                        Text('Add an Item',style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const SizedBox(height: 8),
      ],
    );
  }
}

class DisplaySpendingItem extends StatefulWidget {
  const DisplaySpendingItem({Key? key, required this.items}) : super(key: key);
  final List<SpendingReportMessage> items; // new
  @override
  _DisplaySpendingItemState createState() => _DisplaySpendingItemState();
}

class _DisplaySpendingItemState extends State<DisplaySpendingItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 8),
        // ------MESSAGE display ----------------------------------

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          // height: 600,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.items.length,
            // shrinkWrap: false,
            // addAutomaticKeepAlives: false,
            // addSemanticIndexes: true,
            // semanticChildCount: 3,

            itemBuilder: (BuildContext context, int index) {
              return ListElement(
                iconIndex: widget.items[index].iconIndex,
                text: widget.items[index].item,
                subText: widget.items[index].category,
                price: widget.items[index].price,
              );
            },
            // children: <Widget>[
            //   for (var message in widget.messages)
            //   // Paragraph('${message.name}: ${message.message}: ${message.type}'),
            //     ListElement(message.name, message.message),
            // ],
          ),
        ),

        // const SizedBox(height: 8),
      ],
    );
  }
}

// class SpendingReport extends StatefulWidget {
//   const SpendingReport({required this.addMessage, required this.messages});
//   final FutureOr<void> Function(String message, String type) addMessage;
//   final List<SpendingReportMessage> messages; // new
//
//   @override
//   _SpendingReportState createState() => _SpendingReportState();
// }
//
// class _SpendingReportState extends State<SpendingReport> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_SpendingReportState');
//   final _controller = TextEditingController();
//   final _controller2 = TextEditingController();
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
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 20,
//                       width: 200,
//                       child: TextFormField(
//                         controller: _controller,
//                         decoration: const InputDecoration(
//                           hintText: 'Leave a message',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Enter your message to continue';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 200,
//                       child: TextFormField(
//                         controller: _controller2,
//                         decoration: const InputDecoration(
//                           hintText: 'A fake text Field',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Enter your message to continue';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 8),
//                 StyledButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await widget.addMessage(
//                           _controller.text, _controller2.text);
//                       _controller.clear();
//                       _controller2.clear();
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
//         // ------MESSAGE display ----------------------------------
//
//         ConstrainedBox(
//           constraints: const BoxConstraints(
//             maxHeight: 350,
//           ),
//           child: ListView.builder(
//             padding: const EdgeInsets.all(8),
//             itemCount: widget.messages.length,
//             shrinkWrap: false,
//             // addAutomaticKeepAlives: false,
//             // addSemanticIndexes: true,
//             // semanticChildCount: 3,
//
//             itemBuilder: (BuildContext context, int index) {
//               return ListElement(
//                 text: widget.messages[index].name,
//                 subText: widget.messages[index].message,
//                 price: widget.messages[index].type,
//               );
//             },
//             // children: <Widget>[
//             //   for (var message in widget.messages)
//             //   // Paragraph('${message.name}: ${message.message}: ${message.type}'),
//             //     ListElement(message.name, message.message),
//             // ],
//           ),
//         ),
//
//         const SizedBox(height: 8),
//       ],
//     );
//   }
// }

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _listenerCountSub = FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _email = user.email;
        _spendingReportSubscription = FirebaseFirestore.instance
            .collection('SpendingReport')
            .doc(user.uid)
            .collection(user.uid)
            // .where('userId', isEqualTo: user.uid)
            .orderBy('timestamp', descending: true)
            // .limit(3)
            .snapshots()
            .listen((snapshot) {
          _spendingReportMessages = [];
          for (final document in snapshot.docs) {
            _spendingReportMessages.add(
              SpendingReportMessage(
                name: document.data()['name'] as String,
                price: document.data()['price'] as String,
                item: document.data()['item'] as String,
                category: document.data()['category'] as String,
                iconIndex: document.data()['iconIndex'] as int,
                // timestamp: document.data()['timestamp'] as Timestamp,
              ),
            );
          }
          notifyListeners();
        });

        _attendingSubscription = FirebaseFirestore.instance
            .collection('attendees')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            if (snapshot.data()!['attending'] as bool) {
              _attending = Attending.yes;
            } else {
              _attending = Attending.no;
            }
          } else {
            _attending = Attending.unknown;
          }
          notifyListeners();
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _spendingReportMessages = [];
        _spendingReportSubscription?.cancel();
        _attendingSubscription?.cancel(); // new
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  // ApplicationLoginState _loginState = ApplicationLoginState.loggedIn;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  StreamSubscription<QuerySnapshot>? _spendingReportSubscription;
  List<SpendingReportMessage> _spendingReportMessages = [];
  List<SpendingReportMessage> get spendingReportMessages =>
      _spendingReportMessages;

  int _attendees = 0;
  int get attendees => _attendees;

  Attending _attending = Attending.unknown;
  StreamSubscription<DocumentSnapshot>? _attendingSubscription;
  Attending get attending => _attending;
  set attending(Attending attending) {
    final userDoc = FirebaseFirestore.instance
        .collection('attendees')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (attending == Attending.yes) {
      userDoc.set(<String, dynamic>{'attending': true});
      print('$_attendees people going');
    } else {
      userDoc.set(<String, dynamic>{'attending': false});
      print('$_attendees people going');
    }
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listenerCountSub;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void endLoginFlow() {
    _loginState = ApplicationLoginState.loggedOut;
    notifyListeners();
  }

  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Future<DocumentReference> addMessageToSpendingReport(
  //     String message, String type) {
  //   if (_loginState != ApplicationLoginState.loggedIn) {
  //     throw Exception('Must be logged in');
  //   }
  //
  //   return FirebaseFirestore.instance
  //       .collection('SpendingReport')
  //       .add(<String, dynamic>{
  //     'text': message,
  //     'type': type,
  //     'timestamp': DateTime.now().millisecondsSinceEpoch,
  //     'name': FirebaseAuth.instance.currentUser!.displayName,
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //   });
  // }
  Future<DocumentReference> addMessageToSpendingReport(
      String item, String price, String category, int iconIndex) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('SpendingReport')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .add(<String, dynamic>{
      'item': item,
      'price': price,
      'category': category,
      'iconIndex': iconIndex,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _listenerCountSub?.cancel();

    super.dispose();
  }
}

class YesNoSelection extends StatelessWidget {
  const YesNoSelection({required this.state, required this.onSelection});
  final Attending state;
  final void Function(Attending selection) onSelection;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case Attending.yes:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onSelection(Attending.yes),
                child: const Text('YES'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => onSelection(Attending.no),
                child: const Text('NO'),
              ),
            ],
          ),
        );
      case Attending.no:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () => onSelection(Attending.yes),
                child: const Text('YES'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onSelection(Attending.no),
                child: const Text('NO'),
              ),
            ],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              StyledButton(
                onPressed: () => onSelection(Attending.yes),
                child: const Text('YES'),
              ),
              const SizedBox(width: 8),
              StyledButton(
                onPressed: () => onSelection(Attending.no),
                child: const Text('NO'),
              ),
            ],
          ),
        );
    }
  }
}

class StartHome extends StatefulWidget {
  const StartHome({
    Key? key,
    required this.title,
    required this.email,
  }) : super(key: key);
  final String title;
  final String email;

  @override
  _StartHomeState createState() => _StartHomeState();
}

class _StartHomeState extends State<StartHome> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            width: 100,
            height: 50,
            child: ElevatedButton(
              child: const Text('MSG Test'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SpendingBasePage(email: widget.email),
                  ),
                );
              },

              // onPressed: () async {
              //   try {
              //     await Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => const MessageTestPage(),
              //       ),
              //     );
              //   } catch (e) {
              //     print(e);
              //   }
              // },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 20),
          child: SizedBox(
            width: 100,
            height: 50,
            child: ElevatedButton(
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
                Navigator.pushNamed(context, '/home_page');
              },
              child: const Text('MainPage'),
            ),
          ),
        ),
      ],
    );
  }
}

// class StartHome extends StatefulWidget {
//   const StartHome({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _StartHomeState createState() => _StartHomeState();
// }
//
// class _StartHomeState extends State<StartHome> {
//   bool pressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: SizedBox(
//             width: 100,
//             height: 50,
//             child: ElevatedButton(
//               child: const Text('MSG Test'),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => MessageTestPage(email: '@sss'),
//                   ),
//                 );
//               },
//
//               // onPressed: () async {
//               //   try {
//               //     await Navigator.of(context).push(
//               //       MaterialPageRoute(
//               //         builder: (context) => const MessageTestPage(),
//               //       ),
//               //     );
//               //   } catch (e) {
//               //     print(e);
//               //   }
//               // },
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 18, bottom: 20),
//           child: SizedBox(
//             width: 100,
//             height: 50,
//             child: ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.resolveWith<Color?>(
//                   (Set<MaterialState> states) {
//                     if (states.contains(MaterialState.pressed)) {
//                       return Theme.of(context)
//                           .colorScheme
//                           .primary
//                           .withOpacity(0.5);
//                     }
//                     return null; // Use the component's default.
//                   },
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/home_page');
//               },
//               child: const Text('MainPage'),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

//============================================================================
// class StartHome extends StatefulWidget {
//   const StartHome({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _StartHomeState createState() => _StartHomeState();
// }
//
// class _StartHomeState extends State<StartHome> {
//   bool pressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: SizedBox(
//           width: 100,
//           height: 350,
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               SizedBox(
//                 width: 100,
//                 height: 50,
//                 child: ElevatedButton(
//                     child: const Text('Test Button'), onPressed: () async {}),
//               ),
//               SizedBox(
//                 width: 100,
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color?>(
//                           (Set<MaterialState> states) {
//                         if (states.contains(MaterialState.pressed)) {
//                           return Theme.of(context)
//                               .colorScheme
//                               .primary
//                               .withOpacity(0.5);
//                         }
//                         return null; // Use the component's default.
//                       },
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/home_page');
//                   },
//                   child: const Text('MainPage'),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
