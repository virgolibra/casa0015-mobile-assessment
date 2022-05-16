import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_casa0015_mobile_app/page/item_detail_page.dart';
import 'package:path/path.dart';

class Header extends StatelessWidget {
  const Header(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content);
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class ListElement extends StatelessWidget {
  ListElement(
      {Key? key,
      required this.item,
      required this.category,
      required this.price,
      required this.iconIndex,
      required this.lat,
      required this.lon})
      : super(key: key);
  // const ListElement(this.text, this.subText);
  final String item;
  final String category;
  final String price;
  final int iconIndex;
  final double lat;
  final double lon;

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
    Icons.pets_rounded, // Pets
  ];

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: ListTile(
          leading: Icon(
            iconsList[iconIndex],
            color: Color(0xff936F3E),
            size: 35,
          ),
          title: Text(item),
          subtitle: Text(category),
          tileColor: const Color(0xffF5E0C3),

          trailing: SizedBox(
            height: 40,
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('£'),
                Text(
                  price,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),

          // enabled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Color(0xffF5E0C3),
              width: 2,
            ),
          ),
          onTap: () {
            // Navigator.pushNamed(context, '/first_page');

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ItemDetailPage(
                  lat: lat,
                  lon: lon,
                  item: item,
                  category: category,
                  iconIndex: iconIndex,
                  price: price,
                ),
              ),
            );
          },
        ),
      );
}


class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail);
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xffB28E5E)),
          backgroundColor: const Color(0xffB28E5E),
          textStyle: const TextStyle(fontSize: 15),
        ),
        onPressed: onPressed,
        child: child,
      );
}

class StyledIconButton extends StatelessWidget {
  const StyledIconButton(
      {required this.icon, required this.label, required this.onPressed});
  final Icon icon;
  final Widget label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xffB28E5E),
            width: 2,
          ),
          backgroundColor: const Color(0xffB5BFD3),
          textStyle: const TextStyle(
            fontSize: 15,
          ),
        ),
        onPressed: onPressed,
        label: label,
        icon: icon,
      );
}

class StyledIconButton2 extends StatelessWidget {
  const StyledIconButton2(
      {required this.icon, required this.label, required this.onPressed});
  final Widget icon;
  final Widget label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xffB28E5E)),
          backgroundColor: const Color(0xffB28E5E),
          textStyle: const TextStyle(fontSize: 15),
        ),
        onPressed: onPressed,
        icon: icon,
        label: label,
      );
}

