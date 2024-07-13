import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uji_coba_flutter/controllers/user_controller.dart';
import 'package:uji_coba_flutter/models/user_model.dart';

class UserFormScreen extends StatefulWidget {
  final User? user;
  final bool isEditing;

  UserFormScreen({super.key, this.user, this.isEditing = false});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final UserController userController = Get.find<UserController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();

  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.user != null) {
      emailController.text = widget.user!.email;
      firstNameController.text = widget.user!.firstName;
      lastNameController.text = widget.user!.lastName;
      avatarController.text = widget.user!.avatar;
    }
  }

  Future<void> _requestPermission() async {
    if (await Permission.camera.request().isGranted &&
        await Permission.storage.request().isGranted) {
    } else {}
  }

  Future<void> _pickImage(ImageSource source) async {
    await _requestPermission();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        avatarController.text = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit User' : 'Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: avatarController,
              decoration: const InputDecoration(labelText: 'Avatar URL'),
            ),
            const SizedBox(height: 20),
            _image != null
                ? Image.file(
                    _image!,
                    height: 150,
                  )
                : widget.isEditing && widget.user != null
                    ? widget.user!.avatar.startsWith('http')
                        ? Image.network(
                            widget.user!.avatar,
                            height: 150,
                          )
                        : Image.file(
                            File(widget.user!.avatar),
                            height: 150,
                          )
                    : Container(
                        height: 150,
                        color: Colors.grey[200],
                      ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: const Text('Camera'),
                ),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                final avatarPath = _image?.path ?? avatarController.text;
                if (widget.isEditing) {
                  userController.editUser(
                    widget.user!.id,
                    User(
                      id: widget.user!.id,
                      email: emailController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      avatar: _image?.path ?? avatarController.text,
                    ),
                  );
                } else {
                  userController.addUser(User(
                    id: 0,
                    email: emailController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    avatar: _image?.path ?? avatarController.text,
                  ));
                }
                Get.back();
              },
              child: Text(widget.isEditing ? 'Save' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
