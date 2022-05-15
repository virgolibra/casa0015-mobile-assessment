import 'package:flutter/material.dart';
import '../widgets.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Column(
        children: const [
          Text("This is about page"),
          Header("Credits"),
          Paragraph(
              "https://superdevresources.com/make-better-use-of-about-page-in-your-app/"),
          Paragraph(
              "Credits is an important section to be included in your app’s about page, "
              "specially if you are using free resources that require attribution. "
              "You can also use this section to show your thanks to contributors and people who tested your app.")
        ],
      ),
    );
  }
}
