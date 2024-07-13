import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uji_coba_flutter/models/user_model.dart';

class ApiService {
  static const String apiUrl = 'https://reqres.in/api/users';

  Future<List<User>> fetchUsers() async {
    final responsePage1 = await http.get(Uri.parse(apiUrl + '?page=1'));
    final responsePage2 = await http.get(Uri.parse(apiUrl + '?page=2'));

    if (responsePage1.statusCode == 200 && responsePage2.statusCode == 200) {
      final List<dynamic> dataPage1 = json.decode(responsePage1.body)['data'];
      final List<dynamic> dataPage2 = json.decode(responsePage2.body)['data'];

      final List<dynamic> combinedData = [...dataPage1, ...dataPage2];
      print('Fetched user data: $combinedData');

      return combinedData.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data user');
    }
  }

  Future<void> addUser(User user) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': user.email,
        'first_name': user.firstName,
        'last_name': user.lastName,
        'avatar': user.avatar,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan user');
    }
  }

  Future<void> editUser(int id, User user) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': user.email,
        'first_name': user.firstName,
        'last_name': user.lastName,
        'avatar': user.avatar,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Gagal update user');
    }
  }
}
