import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list2/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _majorController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _isEditing = false;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://media.licdn.com/dms/image/D5603AQFobAxklY_65A/profile-displayphoto-shrink_400_400/0/1701661152828?e=1714608000&v=beta&t=bIfro3DyJJwEwkEAFa3YZhaX5nkHLykGBfe7Px7CUkU'),
                      ),
                Positioned(
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_circle),
                  ),
                  bottom: -12,
                  left: 92,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 48, 25, 16),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  buildProfileField('Name', _nameController.text, 'Abdul Zacky'),
                  SizedBox(height: 40),
                  buildProfileField('Major', _majorController.text, 'Information System'),
                  SizedBox(height: 40),
                  buildProfileField('Date of Birth', _dobController.text, '29/09/2004'),
                  SizedBox(height: 40),
                  buildProfileField('Email', _emailController.text, 'abdul.zacky@ui.ac.id'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 24,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isEditing) {
                        // Save edited data or perform any other action
                        // This is where you would typically update your data
                      }
                      toggleEditing();
                    },
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: Text(_isEditing ? 'Save' : 'Edit'),
                  ),
                ),
                SizedBox(width: 24,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String value, String placeholder) {
    return _isEditing
        ? TextField(
            controller: label == 'Name'
                ? _nameController
                : label == 'Major'
                    ? _majorController
                    : label == 'Date of Birth'
                        ? _dobController
                        : _emailController,
            decoration: InputDecoration(
              labelText: label,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                value.isNotEmpty ? value : placeholder,
                style: TextStyle(fontSize: 17),
              ),
            ],
          );
  }
}
