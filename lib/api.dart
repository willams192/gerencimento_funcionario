import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class Api {
  static const String url = 'http://127.0.0.1:3000/';

  static Future<List<User>> getUsers() async {
    print("aqui 1");
    final response = await http.get(Uri.parse('$url/funcionario'));
    print(response);
    if (response.statusCode == 200) {
      final List<dynamic> usersJson = json.decode(response.body);
      final List<User> funcionarios =
          usersJson.map((json) => User.fromJson(json)).toList();
      return funcionarios;
    } else {
      throw Exception('Failed to load funcionarios');
    }
  }

  static Future<void> addUser(User user) async {
    print("AQUI");
    final response = await http.post(
      Uri.parse('http://localhost:3000/funcionario/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': user.name,
        'email': user.email,
        'avatarUrl': user.avatarUrl
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add user');
    }
  }

  static Future<void> removeUser(String id) async {
    final response = await http.delete(Uri.parse('$url/funcionario/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to remove user');
    }
  }
}
