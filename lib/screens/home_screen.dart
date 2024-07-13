import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uji_coba_flutter/screens/user_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(UserListScreen());
          },
          child: const Text('User List'),
        ),
      ),
    );
  }
}