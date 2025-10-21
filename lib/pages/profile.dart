import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  File? image;
  final ipicker = ImagePicker();
  final nameController = TextEditingController();
  bool isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    loadProfileData();
    _animationController.forward();
  }

  @override
  void dispose() {
    nameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> loadProfileData() async {
    setState(() => isLoading = true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedName = prefs.getString('username');
      String? imagePath = prefs.getString('profile_image');

      if (savedName != null) {
        nameController.text = savedName;
      }
      if (imagePath != null && File(imagePath).existsSync()) {
        setState(() => image = File(imagePath));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> pickImageFrom(ImageSource source) async {
    try {
      final pickedFile = await ipicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() => image = File(pickedFile.path));
        _animationController.reset();
        _animationController.forward();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> saveProfileData() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a username'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', nameController.text.trim());
      if (image != null) {
        await prefs.setString('profile_image', image!.path);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Profile saved successfully!'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF025A3E),
                  ),
                ),
                SizedBox(height: 24),
                _ImageSourceOption(
                  icon: Icons.camera_alt,
                  title: 'Camera',
                  subtitle: 'Take a new photo',
                  onTap: () {
                    Navigator.pop(context);
                    pickImageFrom(ImageSource.camera);
                  },
                ),
                SizedBox(height: 12),
                _ImageSourceOption(
                  icon: Icons.photo_library,
                  title: 'Gallery',
                  subtitle: 'Choose from gallery',
                  onTap: () {
                    Navigator.pop(context);
                    pickImageFrom(ImageSource.gallery);
                  },
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final avatarSize = size.width * 0.45; // Bigger avatar

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(toolbarHeight: 34,
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Profile Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    homepage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOutCubic;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 400),
              ),
            );
          },
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          iconSize: 22,
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.teal,
          strokeWidth: 3,
        ),
      )
          : SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // Gradient header section
            Container(
              height: size.height * 0.08,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.teal,
                    Colors.teal.shade400,
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Profile Image - Centered and bigger
            ScaleTransition(
              scale: _scaleAnimation,
              child: Hero(
                tag: 'profile_image',
                child: GestureDetector(
                  onTap: showImageSourceDialog,
                  child: Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: Offset(0, 10),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipOval(
                          child: image == null
                              ? Container(
                            color: Colors.grey.shade100,
                            child: Icon(
                              Icons.person,
                              color: Colors.grey.shade400,
                              size: avatarSize * 0.55,
                            ),
                          )
                              : Image.file(
                            image!,
                            fit: BoxFit.cover,
                            width: avatarSize,
                            height: avatarSize,
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.teal.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            // User info text
            Text(
              nameController.text.isEmpty
                  ? 'Add your name'
                  : nameController.text,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Username field
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) {
                      setState(() {}); // Update display name
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.teal,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  // Action buttons
                  _ActionButton(
                    onPressed: showImageSourceDialog,
                    icon: Icons.camera_alt,
                    label: 'Change Profile Picture',
                    backgroundColor: Colors.teal.shade50,
                    textColor: Colors.teal.shade700,
                    iconColor: Colors.teal,
                  ),
                  SizedBox(height: 12),
                  _ActionButton(
                    onPressed: saveProfileData,
                    icon: Icons.check_circle_outline,
                    label: 'Save Changes',
                    backgroundColor: Colors.teal,
                    textColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ImageSourceOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ImageSourceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.teal, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const _ActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 22),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}