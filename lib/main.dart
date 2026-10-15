import 'package:english_learning/features/home/ui/home_page.dart';
import 'package:english_learning/features/test/ui/test_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        TestPage.routeName: (context) => TestPage(),
      },
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
