import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class Api {
  static const String url = 'http://192.168.0.199:3000';

  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$url/funcionario'));

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
    try {
      final response = await http.post(
        Uri.parse('$url/funcionario/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl
        }),
      );
      if (response.statusCode == 201 &&
          response.body.contains('usuário cadastrado com sucesso')) {
        print('User added successfully');
      } else {
        throw Exception('Failed to add user: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> removeUser(String id) async {
    final response =
        await http.delete(Uri.parse('$url/funcionario/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to remove user');
    }
  }

  static Future<void> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$url/funcionario/update/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': user.name,
        'email': user.email,
        'avatarUrl': user.avatarUrl,
        'cargo': user.cargo
      }),
    );

    if (response.statusCode == 200 &&
        response.body.contains('Usuário atualizado com sucesso')) {
      print('User updated successfully');
    } else {
      throw Exception('Failed to update user: ${response.body}');
    }
  }
}
