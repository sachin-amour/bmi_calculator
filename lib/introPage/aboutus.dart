import 'package:flutter/material.dart';

import '../pages/homepage.dart';

class AboutUsPage extends StatelessWidget {
  // Define the primary/accent color for consistency
  final Color primaryPurple = Color(0xFF4A00E0);
  final Color secondaryPurple = Color(0xFF8E2DE2);
  final Color lightBlueAccent = Color(0xFFF0F8FF); // For the intro box background

   AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the screen width to adjust the maximum content width
    final screenWidth = MediaQuery.of(context).size.width;
    final contentMaxWidth = 800.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => homepage()));
          },
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 32),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: contentMaxWidth,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Content starts here
                      const SizedBox(height: 40), // Space above the logo
                      _buildLogoSection(),
                      const SizedBox(height: 20),

                      // "Crafting Digital Experiences..." Tagline
                      Center(
                        child: Text(
                          "\"Crafting Digital Experiences with Passion and Precision\"",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),

                      _buildIntroBox(),

                      // --- Section 1: Who Am I? ---
                      _buildSectionHeader("Who Am I?"),
                      _buildSectionText(
                          "I'm a Flutter developer who believes in the power of clean code and elegant design. My journey in mobile development is driven by curiosity, creativity, and a constant desire to learn and innovate."
                      ),

                      const SizedBox(height: 30),

                      // --- Section 2: What I Do ---
                      _buildSectionHeader("What I Do"),
                      _buildSectionText(
                          "I specialize in creating cross-platform mobile applications using Flutter and Dart. From concept to deployment, I bring ideas to life with attention to detail and a focus on user experience. Whether it's a sleek UI, smooth animations, or robust functionality, I ensure every project meets the highest standards."
                      ),

                      const SizedBox(height: 30),

                      // --- Section 3: My Philosophy ---
                      _buildSectionHeader("My Philosophy"),
                      _buildSectionText(
                          "Every line of code tells a story. Every app should not just work—it should inspire. I believe in building applications that users love, with performance that impresses and design that captivates."
                      ),

                      const SizedBox(height: 30),

                      // --- Section 4: Let's Connect ---
                      _buildSectionHeader("Let's Connect"),
                      _buildSectionText(
                          "This blog is where I share my thoughts, experiences, and insights on Flutter development, mobile technology, and the ever-evolving world of software engineering. Join me on this journey as we explore, learn, and grow together."
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            // --- 4. Footer Section ---
            _buildFooter(),
          ],
        ),
      ),
    );
  }
  Widget _buildLogoSection() {
    return Center(
      child: Column(
        children: [
          // Placeholder for the custom leaf icon/logo
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green.shade300, width: 2),
            ),
            child: Image.asset(
              'assets/images/mylogo.png',
              width: 100,
              height: 100,
            )
          ),
          const SizedBox(height: 10),
          const Text(
            "AMOUR",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: Color(0xFF2E8B57), // A deep green color
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroBox() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 40.0),
      decoration: BoxDecoration(
        color: lightBlueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hello! I'm Sachin Sharma",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "A passionate Flutter Developer dedicated to building beautiful, functional, and user-friendly mobile applications that make a difference.",
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryPurple,
        ),
      ),
    );
  }

  Widget _buildSectionText(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 16,
        height: 1.6, // Increased height for better web readability
        color: Colors.black87,
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: Center(
        child: Text(
          '© 2025 Amour. All rights reserved.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}