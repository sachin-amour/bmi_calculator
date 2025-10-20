import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluter_base/introPage/splashpage.dart';

import 'introPage/intropage_1.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  runApp(myApp(showOnboarding: !hasSeenOnboarding));
}

class myApp extends StatelessWidget {
  final bool showOnboarding;

  const myApp({required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showOnboarding ? OnboardingScreen() : SplashPage(),
    );
  }
}