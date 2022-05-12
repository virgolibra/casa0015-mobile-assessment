import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_casa0015_mobile_app/page/message_test_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';
import '../authentication.dart';
import '../widgets.dart';

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
                  const StartHome(
                    title: 'TestStartHome',
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
  SpendingReportMessage({required this.name, required this.message});
  final String name;
  final String message;
}

enum Attending { yes, no, unknown }

class SpendingReport extends StatefulWidget {
  const SpendingReport({required this.addMessage, required this.messages});
  final FutureOr<void> Function(String message) addMessage;
  final List<SpendingReportMessage> messages; // new

  @override
  _SpendingReportState createState() => _SpendingReportState();
}

class _SpendingReportState extends State<SpendingReport> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_SpendingReportState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Leave a message',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.addMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('SEND'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        for (var message in widget.messages)
          Paragraph('${message.name}: ${message.message}'),
        const SizedBox(height: 8),
      ],
    );
  }
}

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
        _spendingReportSubscription = FirebaseFirestore.instance
            .collection('SpendingReport')
            .orderBy('timestamp', descending: true)
            .limit(3)
            .snapshots()
            .listen((snapshot) {
          _spendingReportMessages = [];
          for (final document in snapshot.docs) {
            _spendingReportMessages.add(
              SpendingReportMessage(
                name: document.data()['name'] as String,
                message: document.data()['text'] as String,
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
  List<SpendingReportMessage> get spendingReportMessages => _spendingReportMessages;

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

  Future<DocumentReference> addMessageToSpendingReport(String message) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('SpendingReport')
        .add(<String, dynamic>{
      'text': message,
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
  const StartHome({Key? key, required this.title}) : super(key: key);
  final String title;

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
                Navigator.pushNamed(context, '/message_test_page');
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
