
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'introPage/intropage_1.dart';


void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'first_app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnboardingScreen(),
    );
  }
}
