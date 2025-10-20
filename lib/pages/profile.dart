import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  File? image;
  var ipicker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('username');
    String? imagePath = prefs.getString('profile_image');

    if (savedName != null) {
      nameController.text = savedName;
    }
    if (imagePath != null && File(imagePath).existsSync()) {
      image = File(imagePath);
    }
    setState(() {});
  }

  Future<void> pickImage_Gallery() async {
    final pickedFile = await ipicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> pickImage_Camera() async {
    final pickedFile = await ipicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', nameController.text);
    if (image != null) {
      await prefs.setString('profile_image', image!.path);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 170,
              child: Container(
                height: 550,
                width: 411,
                decoration: BoxDecoration(
                  color: Color(0xFFA2F6DD),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 155),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF025A3E),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: TextField(
                        controller: nameController, style: TextStyle(fontSize:20 ),
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: Color(0xFF025A3E),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Select any'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.camera_alt),
                                    title: Text("Camera"),
                                    onTap: () {
                                      pickImage_Camera();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo_outlined),
                                    title: Text("Gallery"),
                                    onTap: () {
                                      pickImage_Gallery();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF025A3E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: saveProfileData,
                        child: Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF025A3E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 100,
              top: 114,
              child: ClipOval(
                child: image == null
                    ? Icon(
                  Icons.account_circle,
                  color: Colors.blueGrey.shade300,
                  size: 220,
                )
                    : Image.file(image!, width: 220, height: 220, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}