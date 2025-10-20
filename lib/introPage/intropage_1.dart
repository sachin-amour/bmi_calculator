import 'package:fluter_base/introPage/splashpage.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnboardingPageData {
  final String imagePath; // local asset path (or URL if you use network images)
  final String title;
  final String subtitle;

  OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controller for the PageView
  final PageController _pageController = PageController(initialPage: 0);

  // Current page index (used to change button behavior/text)
  int _currentIndex = 0;

  // Data for each onboarding page - update imagePath to your asset filenames
  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      imagePath: 'assets/images/health.png',
      title: 'Health Calculator',
      subtitle: 'Unlock Your Health Potential with Our Calculators',
    ),
    OnboardingPageData(
      imagePath: 'assets/images/progress_chart.png',
      title: 'Track Progress',
      subtitle: 'Monitor your daily activities and progress easily',
    ),
    // OnboardingPageData(
    //   imagePath: 'assets/images/article.png',
    //   title: 'Read Articles',
    //   subtitle: 'Get tips and reminders to achieve your goals',
    // ),
  ];

  @override
  void dispose() {
    _pageController.dispose(); // always dispose controllers
    super.dispose();
  }

  void _onNextPressed() {
    final lastPage = pages.length - 1;
    if (_currentIndex == lastPage) {
      // We're on the last page — navigate away (replace with your home screen)
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => SplashPage()));
    } else {
      // go to next page with an animation
      _pageController.nextPage(
        duration: Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildPage(OnboardingPageData data, BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(height: height * 0.06),
          // Illustration area (change BoxFit & size to suit your images)
          SizedBox(
            height: height * 0.45,
            child: Image.asset(
              data.imagePath,
              fit: BoxFit.contain,
              // semanticLabel helps accessibility/screen readers
              semanticLabel: 'Illustration for ${data.title}',
            ),
          ),
          SizedBox(height: 28),
          Text(
            data.title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            data.subtitle,
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lastPage = pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Expanded PageView (swipeable)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return buildPage(pages[index], context);
                },
              ),
            ),

            // Dots indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0, top: 6),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: pages.length,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 12,
                  activeDotColor: Colors.green,
                  dotColor: Colors.grey.shade300,
                ),
                // make dots tappable
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),

            // Big full-width button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 18,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    _currentIndex == lastPage ? 'Get Started' : 'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

