import 'package:fluter_base/pages/bmr.dart';
import 'package:fluter_base/pages/profile.dart';
import 'package:fluter_base/pages/waterIntect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IdealbodyWeight.dart';
import 'bmi.dart';
import 'bodyfat.dart';
import 'calculator.dart';
import '../introPage/slidebarmenu.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Profile(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardSize = (size.width - 60) / 2; // Dynamic card size

    return Scaffold(
      drawer: slidler(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: ScaleTransition(
        scale: _fadeAnimation,
        child: FloatingActionButton(
          onPressed: () => _navigateToProfile(context),
          tooltip: 'Go to Profile',
          backgroundColor: Colors.teal,
          elevation: 4,
          child: const Icon(Icons.person, color: Colors.white, size: 28),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Calculators',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Track your health metrics',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 24),
                // Calculator Grid
                _AnimatedCalculatorGrid(
                  cardSize: cardSize,
                  animationController: _animationController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedCalculatorGrid extends StatelessWidget {
  final double cardSize;
  final AnimationController animationController;

  const _AnimatedCalculatorGrid({
    required this.cardSize,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(
          context,
          [
            _CalculatorCard(
              title: 'BMI',
              subtitle: 'Body Mass Index',
              image: 'assets/images/bmi.png',
              onTap: () => _navigateWithAnimation(context, myHome()),
              delay: 0,
              cardSize: cardSize,
            ),
            _CalculatorCard(
              title: 'BMR',
              subtitle: 'Basal Metabolic Rate',
              image: 'assets/images/bmr.png',
              onTap: () => _navigateWithAnimation(context, BMRCalculatorPage()),
              delay: 100,
              cardSize: cardSize,
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildRow(
          context,
          [
            _CalculatorCard(
              title: 'Body Fat',
              subtitle: 'Fat Percentage',
              image: 'assets/images/body_fat.png',
              onTap: () => _navigateWithAnimation(context, bodyfat()),
              delay: 200,
              cardSize: cardSize,
            ),
            _CalculatorCard(
              title: 'Water Intake',
              subtitle: 'Daily Hydration',
              image: 'assets/images/water.png',
              onTap: () => _navigateWithAnimation(context, Waterintectpage()),
              delay: 300,
              cardSize: cardSize,
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildRow(
          context,
          [
            _CalculatorCard(
              title: 'Ideal Weight',
              subtitle: 'Target Body Weight',
              image: 'assets/images/weight.png',
              onTap: () => _navigateWithAnimation(context, IBWCalculatorPage()),
              delay: 400,
              cardSize: cardSize,
            ),
            _CalculatorCard(
              title: 'Calculator',
              subtitle: 'Basic Math',
              image: 'assets/images/calculator.png',
              onTap: () => _navigateWithAnimation(context, Calculator()),
              delay: 500,
              cardSize: cardSize,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  void _navigateWithAnimation(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var scaleTween = Tween<double>(begin: 0.8, end: 1.0).chain(
            CurveTween(curve: Curves.easeOutCubic),
          );
          var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

          return ScaleTransition(
            scale: animation.drive(scaleTween),
            child: FadeTransition(
              opacity: animation.drive(fadeTween),
              child: child,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 350),
      ),
    );
  }
}

class _CalculatorCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onTap;
  final int delay;
  final double cardSize;

  const _CalculatorCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
    required this.delay,
    required this.cardSize,
  });

  @override
  State<_CalculatorCard> createState() => _CalculatorCardState();
}

class _CalculatorCardState extends State<_CalculatorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Staggered entrance animation
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.delay <= 500 ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTapDown: (_) {
            setState(() => _isPressed = true);
            _controller.forward();
          },
          onTapUp: (_) {
            setState(() => _isPressed = false);
            _controller.reverse();
            widget.onTap();
          },
          onTapCancel: () {
            setState(() => _isPressed = false);
            _controller.reverse();
          },
          child: Container(
            height: widget.cardSize,
            width: widget.cardSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isPressed ? 0.1 : 0.15),
                  blurRadius: _isPressed ? 8 : 12,
                  offset: Offset(0, _isPressed ? 2 : 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  // Text overlay
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}