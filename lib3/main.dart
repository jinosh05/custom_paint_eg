import 'package:flutter/material.dart';

import 'pages/painting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Painting Demo',
      theme: ThemeData.light(),
      home: const PaintingPage(),
    );
  }
}
