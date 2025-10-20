// test/widget_test.dart

import 'package:fluter_base/introPage/intropage_1.dart'; // Assuming OnboardingScreen is here
import 'package:fluter_base/introPage/splashpage.dart';
import 'package:fluter_base/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Note: You might need to import your actual home page widget to verify the final navigation.
// import 'package:fluter_base/home_page.dart'; // Example import

void main() {
  // group('Onboarding and Splash Flow', () {
  //   testWidgets('should display page 1 of onboarding initially', (WidgetTester tester) async {
  //     // Build the app starting at the OnboardingScreen
  //     await tester.pumpWidget(myApp());
  //     await tester.pumpAndSettle();
  //
  //     // Verify Page 1 content is visible
  //     expect(find.text('Health Calculator'), findsOneWidget);
  //     expect(find.text('Unlock Your Health Potential with Our Calculators'), findsOneWidget);
  //     expect(find.widgetWithText(ElevatedButton, 'Next'), findsOneWidget);
  //
  //     // Verify Page 2 content is not visible
  //     expect(find.text('Track Progress'), findsNothing);
  //   });
  //
  //   testWidgets('should navigate to page 2 when "Next" is tapped', (WidgetTester tester) async {
  //     await tester.pumpWidget(myApp());
  //     await tester.pumpAndSettle();
  //
  //     // Tap the 'Next' button
  //     await tester.tap(find.widgetWithText(ElevatedButton, 'Next'));
  //     await tester.pumpAndSettle(); // Wait for page transition and animations
  //
  //     // Verify Page 1 is gone and Page 2 is visible
  //     expect(find.text('Health Calculator'), findsNothing);
  //     expect(find.text('Track Progress'), findsOneWidget);
  //     expect(find.text('Monitor your daily activities and progress easily'), findsOneWidget);
  //     expect(find.widgetWithText(ElevatedButton, 'Get Started'), findsOneWidget);
  //   });
  //
  //   testWidgets('should navigate to HomePage after completing onboarding and splash', (WidgetTester tester) async {
  //     await tester.pumpWidget(myApp());
  //     await tester.pumpAndSettle();
  //
  //     // Navigate through onboarding
  //     await tester.tap(find.widgetWithText(ElevatedButton, 'Next'));
  //     await tester.pumpAndSettle();
  //
  //     // Tap 'Get Started' to navigate to SplashPage
  //     await tester.tap(find.widgetWithText(ElevatedButton, 'Get Started'));
  //     await tester.pump(); // First pump to initiate navigation
  //
  //     // Verify SplashPage is now visible
  //     expect(find.byType(SplashPage), findsOneWidget);
  //
  //     // Wait for the splash screen's timer to complete
  //     await tester.pump(const Duration(seconds: 3)); // A little more than the splash duration
  //     await tester.pumpAndSettle(); // Settle all post-splash navigation
  //
  //     // Verify SplashPage is gone
  //     expect(find.byType(SplashPage), findsNothing);
  //
  //     // **IMPORTANT**: Verify that the correct final screen is displayed.
  //     // Replace 'MyHomePage' with the actual widget for your app's home screen.
  //     // expect(find.byType(MyHomePage), findsOneWidget);
  //   });
  // });
}
