// test/widget_test.dart

import 'package:fluter_base/introPage/intropage_1.dart';
import 'package:fluter_base/introPage/splashpage.dart';
import 'package:fluter_base/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OnboardingScreen initial state and navigation test', (WidgetTester tester) async {
    // 1. Build the app and trigger a frame.
    // The home of myApp is OnboardingScreen, so this starts the test there.
    await tester.pumpWidget(myApp());

    // Wait for any animations to settle (good practice for widget tests)
    await tester.pumpAndSettle();

    // The two pages are:
    // Page 1: 'Health Calculator' / 'Next' button
    // Page 2: 'Track Progress' / 'Get Started' button

    // --- Verification of Initial State (Page 1) ---

    // Verify Page 1 title and subtitle are visible
    expect(find.text('Health Calculator'), findsOneWidget);
    expect(find.text('Unlock Your Health Potential with Our Calculators'), findsOneWidget);

    // Verify the initial button text is 'Next'
    expect(find.widgetWithText(ElevatedButton, 'Next'), findsOneWidget);

    // Verify Page 2 content is NOT visible initially
    expect(find.text('Track Progress'), findsNothing);


    // --- Test Navigation to Page 2 ---

    // Find and tap the 'Next' button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Next'));

    // Pump the widget to trigger the animation from PageController.nextPage
    // (We use a few pumps because SmoothPageIndicator uses animations)
    await tester.pump(Duration(milliseconds: 500));
    await tester.pumpAndSettle(); // Settle any remaining animations

    // Verify Page 1 content is gone
    expect(find.text('Health Calculator'), findsNothing);

    // Verify Page 2 title and subtitle are visible
    expect(find.text('Track Progress'), findsOneWidget);
    expect(find.text('Monitor your daily activities and progress easily'), findsOneWidget);

    // Verify the button text has changed to 'Get Started'
    expect(find.widgetWithText(ElevatedButton, 'Get Started'), findsOneWidget);


    // --- Test Final Navigation (Get Started) ---

    // Find and tap the 'Get Started' button
    // Tap 'Get Started' to navigate to SplashPage
    await tester.tap(find.widgetWithText(ElevatedButton, 'Get Started'));
    await tester.pump(); // triggers navigation

// Simulate the 2-second timer inside SplashPage
    await tester.pump(Duration(seconds: 2));

// Now SplashPage should be in the tree
    expect(find.byType(SplashPage), findsOneWidget);

// Simulate any final navigation from SplashPage (if it auto-navigates)
    await tester.pumpAndSettle();

// Confirm SplashPage is gone
    expect(find.byType(SplashPage), findsNothing);


// 4. (OPTIONAL BUT RECOMMENDED) Use pumpAndSettle one last time to clear the internal Timer in splashpage
// If you implemented the fix to cancel the Timer in splashpage's dispose(), this step is less critical
// but still good to ensure the test fully completes its asynchronous tasks.
    await tester.pumpAndSettle();

    // 5. Check if the splashpage has navigated away to the final screen.
    // (Assuming the final screen after the splashpage is called 'MyHomePage')
    // If you don't know the exact name of the destination, you can just rely on pumpAndSettle
    // and remove the final assertion, as the main goal is to clear the timer.
    // Replace MyHomePage with the actual destination widget of your splashpage.
    // expect(find.byType(MyHomePage), findsOneWidget);

    // OR simply assert that the splashpage is no longer in the tree.
    expect(find.byType(SplashPage), findsNothing);
  });
}