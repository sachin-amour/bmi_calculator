import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart'; // Import share_plus

import '../pages/profile.dart';
import 'aboutus.dart';
import 'contact.dart';

class slidler extends StatefulWidget {
  @override
  State<slidler> createState() => _slidlerState();
}

class _slidlerState extends State<slidler> {
  String username = 'Guest';
  File? profileImage;

  // --- Share App Details ---
  final String appLink = "https://play.google.com/store/apps/details?id=com.yourapp.id"; // <<-- REPLACE with your actual app link
  final String shareMessage = "Check out this awesome app! You can download it here:";

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('username');
    String? imagePath = prefs.getString('profile_image');

    setState(() {
      if (name != null && name.isNotEmpty) {
        username = name;
      }
      if (imagePath != null && File(imagePath).existsSync()) {
        profileImage = File(imagePath);
      }
    });
  }

  // --- 1. Function to handle the actual sharing ---
  void _shareApp() {
    final String text = "$shareMessage\n$appLink";
    // Closes the Drawer first before showing the share sheet (good UX)
    Navigator.pop(context);
    Share.share(text, subject: 'App Recommendation');
  }

  // --- 2. Function to show the Share Dialog Popup ---
  void _showShareDialog() {
    // Closes the Drawer first (optional, but cleaner)
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Share This App'),
          content: const Text(
              'Help us grow by sharing this useful application with your friends and family!',
              style: TextStyle(fontSize: 16)),
          actions: <Widget>[
            // Cancel Button
            TextButton(
              child: const Text('Not Now', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            // Share Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _shareApp(); // Call the share function
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Matching your theme
              ),
              child: const Text('Share', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username, style: TextStyle(fontSize: 25)),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              child: profileImage == null
                  ? Icon(Icons.person, size: 50, color: Colors.teal)
                  : ClipOval(
                child: Image.file(
                  profileImage!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.teal),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings', style: TextStyle(fontSize: 25)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => profile()));
            },
          ),
          // --- MODIFIED Share App ListTile ---
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share App', style: TextStyle(fontSize: 25)),
            onTap: () {
              // CALL THE POPUP FUNCTION HERE
              _showShareDialog();
            },
          ),
          // ------------------------------------
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('contact us', style: TextStyle(fontSize: 25)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us', style: TextStyle(fontSize: 25)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutUsPage()));
            },
          ),
        ],
      ),
    );
  }
}