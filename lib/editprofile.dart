import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/services/database.dart'; // Adjust import path as per your project structure

class EditProfilePage extends StatefulWidget {
  final String username;
  final String email;
  final String phoneNo;
  final String avatarurl;

  const EditProfilePage({
    Key? key,
    required this.username,
    required this.email,
    required this.phoneNo,
    required this.avatarurl,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController bioController;

  final DatabaseService _db = DatabaseService(); // Instantiate DatabaseService

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.username);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phoneNo);
    bioController = TextEditingController(text: 'I love fast food');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    String uid = 'Hwk6nxoDNb58y9W6ek7w'; // Replace with actual user ID
    String newName = nameController.text.trim();
    String newEmail = emailController.text.trim();
    String newPhoneNo = phoneController.text.trim();
    String newBio = bioController.text.trim();

    try {
      await _db.updateUserData(
        uid,
        name: newName,
        email: newEmail,
        phoneNumber: newPhoneNo,
        bio: newBio,
      );
      // Show success message or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
      print('Error updating profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 221, 198, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 221, 198, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color.fromRGBO(50, 52, 62, 1),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: constraints.maxWidth * 0.15,
                    backgroundColor: Colors.grey,
                    backgroundImage: widget.avatarurl.isNotEmpty
                        ? AssetImage(widget.avatarurl)
                        : null,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: constraints.maxWidth * 0.05,
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.03),
                  ProfileTextField(
                    label: 'Full Name',
                    controller: nameController,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.03),
                  ProfileTextField(
                    label: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.03),
                  ProfileTextField(
                    label: 'Phone Number',
                    controller: phoneController,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.03),
                  ProfileTextField(
                    label: 'Bio',
                    controller: bioController,
                    maxLines: 3,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.19),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text('SAVE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;

  ProfileTextField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      maxLines: maxLines,
    );
  }
}
