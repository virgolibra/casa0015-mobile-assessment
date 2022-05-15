import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_casa0015_mobile_app/page/spending_base_page.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';
import 'login_page.dart';

class SpendingDisplayPage extends StatefulWidget {
  const SpendingDisplayPage({Key? key}) : super(key: key);

  @override
  State<SpendingDisplayPage> createState() => _SpendingDisplayPageState();
}

class _SpendingDisplayPageState extends State<SpendingDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // Image.asset('assets/image1.jpg'),
        const SizedBox(height: 8),
        // const IconAndDetail(Icons.notes_outlined, 'Spending Items'),
        // const Divider(
        //   height: 8,
        //   thickness: 2,
        //   indent: 8,
        //   endIndent: 8,
        //   color: Colors.grey,
        // ),
        // Container(
        //     color: Colors.orange,
        //     child: const IconAndDetail(
        //         Icons.login_rounded, 'Message Test Page')),

        Consumer<ApplicationState>(
          builder: (context, appState, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DisplaySpendingItem(
                messages: appState.spendingReportMessages,
              ),
            ],
          ),
        ),

      ],
    );
  }
}
