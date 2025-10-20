import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // ⬅️ NEW IMPORT

import '../pages/homepage.dart';

class ContactUsPage extends StatelessWidget {
  final Color primaryPurple = const Color(0xFF4A00E0);
  final Color secondaryPurple = const Color(0xFF8E2DE2);
  final double contentMaxWidth = 800.0;

  ContactUsPage({super.key});

  // Function to safely launch URLs
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          'Get In Touch',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homepage()),
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "We're always open to new connections! Reach out for collaborations, support, or just a friendly chat.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color:Color(0xFF123851),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 600) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _buildQuickContactInfo()),
                                const SizedBox(width: 40),
                                Expanded(child: _buildSocialLinks()),
                              ],
                            );
                          } else {

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildQuickContactInfo(),
                                const SizedBox(height: 40),
                                _buildSocialLinks(),
                              ],
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 50),
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

  // --- EXISTING CONTACT INFO WIDGETS ---

  Widget _buildQuickContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Quick Contact",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryPurple,
          ),
        ),
        const Divider(color: Colors.grey),
        _buildContactItem(Icons.email, "Email", "sachinsharma62091@gmail.com"),
        const SizedBox(height: 15),
        _buildContactItem(Icons.phone, "Phone", "+91 7667834733"),
        const SizedBox(height: 15),
        _buildContactItem(
          Icons.location_on,
          "Location",
          "jamshedpur,jharkhand,india",
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String title, String subtitle) {
    // ... (unchanged)
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: primaryPurple, size: 24),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildSocialLinks() {
    // Replace these placeholders with your actual profile links
    const String linkedinUrl = 'https://www.linkedin.com/in/sachin-sharma-profile/';
    const String facebookUrl = 'https://www.facebook.com/sachin.sharma.page/';
    // WhatsApp link format: "whatsapp://send?phone=<country_code><number>"
    const String whatsappUrl = 'whatsapp://send?phone=+917667834733';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Let's Connect",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryPurple,
          ),
        ),
        const Divider(color: Colors.grey),

        // Social Media Icons Row
        Row(
          children: <Widget>[
            _buildSocialIcon(
                FontAwesomeIcons.linkedin,
                'LinkedIn',
                linkedinUrl,
                Color(0xFF0077B5)
            ),
            _buildSocialIcon(
                FontAwesomeIcons.facebook,
                'Facebook',
                facebookUrl,
                Color(0xFF3b5998)
            ),
            _buildSocialIcon(
                FontAwesomeIcons.whatsapp,
                'WhatsApp',
                whatsappUrl,
                Color(0xFF25D366)
            ),
          ].map((widget) => Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: widget,
          )).toList(),
        ),

        const SizedBox(height: 20),
        const Text(
          "Follow me and reach out instantly on my social media profiles.",
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }


  Widget _buildSocialIcon(IconData icon, String label, String url, Color iconColor) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: () => _launchURL(url),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28, color: iconColor),
        ),
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
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ),
    );
  }
}