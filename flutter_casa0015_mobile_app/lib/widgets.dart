import 'package:flutter/material.dart';
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
          textStyle: const TextStyle(fontSize: 15,),
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

// class StyledButton2 extends StatelessWidget {
//   const StyledButton2({required this.child, required this.onPressed});
//   final Widget child;
//   final void Function() onPressed;
//
//   @override
//   Widget build(BuildContext context) => OutlinedButton(
//     style: OutlinedButton.styleFrom(
//       side: const BorderSide(color: Color(0xff6D42CE)),
//       backgroundColor: const Color(0xff6D42CE),
//       textStyle: const TextStyle(fontSize: 15),
//
//     ),
//     onPressed: onPressed,
//     child: child,
//   );
// }
