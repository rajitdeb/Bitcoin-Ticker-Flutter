import 'package:flutter/material.dart';

import 'screens/price_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColorDark: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const PriceScreen(),
    );
  }
}
