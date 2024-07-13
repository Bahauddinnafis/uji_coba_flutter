import 'package:get/get.dart';
import 'package:uji_coba_flutter/models/user_model.dart';
import 'package:uji_coba_flutter/services/api_service.dart';

class UserController extends GetxController {
  var userList = <User>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      print('Fetching users...');
      var users = await ApiService().fetchUsers();
      userList.assignAll(users);
      print('Fetched users: ${userList.length}');
    } catch (e) {
      print('Failed to fetch users: $e');
    } finally {
      isLoading(false);
    }
  }

  void addUser(User user) async {
    try {
      isLoading(true);
      await ApiService().addUser(user);
      print('User added. Updating user list...');
      userList.add(user); // Tambahkan user langsung ke list
    } catch (e) {
      print('Failed to add user: $e');
    } finally {
      isLoading(false);
    }
  }

  void editUser(int id, User user) async {
    try {
      isLoading(true);
      await ApiService().editUser(id, user);
      print('User edited. Updating user list...');
      final index = userList.indexWhere((u) => u.id == id);
      if (index != -1) {
        userList[index] = user; // Perbarui user di list
      }
    } catch (e) {
      print('Failed to edit user: $e');
    } finally {
      isLoading(false);
    }
  }
}