import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';
import 'login_page.dart';

class SpendingDisplayPage extends StatelessWidget {
  const SpendingDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending Display'),
      ),
      body: ListView(
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
          // const Divider(
          //   height: 8,
          //   thickness: 2,
          //   indent: 8,
          //   endIndent: 8,
          //   color: Colors.grey,
          // ),

        ],
      ),
    );
  }
}
