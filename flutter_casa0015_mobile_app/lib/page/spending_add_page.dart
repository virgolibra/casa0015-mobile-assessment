import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';
import 'login_page.dart';
import 'drawer_page.dart';

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
    Icons.pets_rounded,     // Pets
  ];

  List<String> iconsListDescription = [
    'General','Bills', 'Eating out', 'Delivery', 'Entertainment', 'Gifts', 'Groceries',
    'Travel', 'Shopping', 'Transport', 'Personal care', 'Pets',
  ];

  int buttonOnPressed = 0;
  // int iconDescriptionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffDEC29B),
      child: ListView(
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
                  addItem: (item, price) =>
                      appState.addMessageToSpendingReport(item, price, iconsListDescription[buttonOnPressed], buttonOnPressed),

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

          Column(
            children: [
              Text(iconsListDescription[buttonOnPressed]),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 120,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: const Color(0xffC9A87C),
                    borderRadius: BorderRadius.circular(10)),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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

          const Header("CASA0015 Assessment"),
          const Paragraph(
            'Mobile application development for casa0015-assessment',
          ),
        ],
      ),
    );
  }
}
