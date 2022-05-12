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
          const IconAndDetail(
              Icons.login_rounded, 'Message Test Page'),
          const Header('Discussion'),

          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GuestBook(
                  addMessage: (message) =>
                      appState.addMessageToGuestBook(message),
                  messages: appState.guestBookMessages,
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

// class GuestBookMessage {
//   GuestBookMessage({required this.name, required this.message});
//   final String name;
//   final String message;
// }

enum Attending { yes, no, unknown }

class GuestBook extends StatefulWidget {
  const GuestBook({required this.addMessage, required this.messages});
  final FutureOr<void> Function(String message) addMessage;
  final List<GuestBookMessage> messages; // new

  @override
  _GuestBookState createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
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


class ApplicationState2 extends ChangeNotifier {
  ApplicationState2() {
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
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .limit(3)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          for (final document in snapshot.docs) {
            _guestBookMessages.add(
              GuestBookMessage(
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
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
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

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

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

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('guestbook')
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