import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uji_coba_flutter/controllers/user_controller.dart';
import 'package:uji_coba_flutter/screens/user_form_screen.dart';

class UserListScreen extends StatelessWidget {
  UserListScreen({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.to(() => UserFormScreen());
              userController.fetchUsers();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: userController.userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 40.0,
                  backgroundImage:
                      NetworkImage(userController.userList[index].avatar),
                ),
                title: Text(
                  '${userController.userList[index].firstName} ${userController.userList[index].lastName}',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  userController.userList[index].email,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Get.to(() => UserFormScreen(
                          user: userController.userList[index],
                          isEditing: true,
                        ));
                    userController.fetchUsers();
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
