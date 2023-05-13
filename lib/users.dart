import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import './user.dart';
import 'api.dart';

class Users with ChangeNotifier {
  final List<User> _items = [];

  // Getter para obter todos os usuários
  List<User> get all {
    _fetchUsers();
    return [..._items];
  }

  // Getter para obter o número de usuários
  int get count {
    return _items.length;
  }

  // Método para adicionar um novo usuário ou atualizar um usuário existente
  void put(User user) {
    if (user == null) {
      return;
    }
    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.any((item) => item.id == user.id)) {
      // Atualiza um usuário existente
      final index = _items.indexWhere((item) => item.id == user.id);
      _items[index] = User(
        id: user.id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
      );
    } else {
      // Adiciona um novo usuário
      final id = Uuid().v4();
      final newUser = User(
        id: id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
      );
      _items.add(newUser);
    }
    notifyListeners();
  }

  // Método para remover um usuário
  void remove(User user) {
    if (user != null && user.id != null) {
      _items.removeWhere((item) => item.id == user.id);
      notifyListeners();
    }
  }

  // Método para obter um usuário pelo índice
  User byIndex(int i) {
    return _items[i];
  }

  // Método privado para buscar usuários na API e atualizar a lista
  Future<void> _fetchUsers() async {
    try {
      List<User> users = await Api.getUsers();
      _items.clear();
      _items.addAll(users);
    } catch (e) {
      // não esquecer de fazer os erros -------------------------------------------------------------------------------------------------
    }
  }
}
