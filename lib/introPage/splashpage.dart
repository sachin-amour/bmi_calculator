import 'dart:async';

import 'package:fluter_base/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  void initState() {
    super.initState();
    _timer =Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homepage()),
      );
    });
  }
  @override
  void dispose() {
    _timer?.cancel(); // Add this line to cancel the timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(child: Image.asset('assets/images/mylogo.png')),
      ),
    );
  }
}
