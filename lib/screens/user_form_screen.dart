import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uji_coba_flutter/controllers/user_controller.dart';
import 'package:uji_coba_flutter/models/user_model.dart';

class UserFormScreen extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final User? user;
  final bool isEditing;

  UserFormScreen({super.key, this.user, this.isEditing = false});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isEditing && user != null) {
      emailController.text = user!.email;
      firstNameController.text = user!.firstName;
      lastNameController.text = user!.lastName;
      avatarController.text = user!.avatar;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit User' : 'Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
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
            ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  userController.editUser(
                      user!.id,
                      User(
                        id: user!.id,
                        email: emailController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        avatar: avatarController.text,
                      ));
                } else {
                  userController.addUser(User(
                    id: 0,
                    email: emailController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    avatar: avatarController.text,
                  ));
                }
                Get.back();
              },
              child: Text(isEditing ? 'Save' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}