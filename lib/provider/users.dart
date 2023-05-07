import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static const String url = 'http://127.0.0.1:3000/user/add';

  static Future<List> getUsers() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> usersJson = json.decode(response.body);
      final List users = usersJson.map((json) => User.fromMap(json)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

class Users with ChangeNotifier {
  final List<User> items = [];

  Users() {
    _fetchUsers();
  }

  List<User> get all {
    return [...items];
  }

  int get count {
    return items.length;
  }

  User byIndex(int i) {
    return items[i];
  }

  void put(User user) {
    if (user == null) {
      return;
    }
    if (user.id != null &&
        user.id!.trim().isNotEmpty &&
        items.any((element) => element.id == user.id)) {
      final index = items.indexWhere((element) => element.id == user.id);
      items[index] = User(
        id: user.id,
        name: user.name,
        email: user.email,
        avatarurl: user.avatarurl,
      );
    } else {
      items.add(
        User(
          id: Random().nextDouble().toString(),
          name: user.name,
          email: user.email,
          avatarurl: user.avatarurl,
        ),
      );
    }
    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      items.removeWhere((element) => element.id == user.id);
      notifyListeners();
    }
  }

  Future<void> _fetchUsers() async {
    final List<dynamic> usersData = await UserService.getUsers();
    final List<User> users =
        usersData.map((user) => User.fromMap(user)).cast<User>().toList();
    items.clear();
    items.addAll(users);
    notifyListeners();
  }
}
