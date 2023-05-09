import 'dart:math';
import 'package:flutter/material.dart';
import './user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {};

  // Getter para obter todos os usuários
  List<User> get all {
    return [..._items.values];
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
        _items.containsKey(user.id)) {
      // Atualiza um usuário existente
      _items.update(
        user.id,
        (_) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    } else {
      // Adiciona um novo usuário
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  // Método para remover um usuário
  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }

  // Método para obter um usuário pelo índice
  User byIndex(int i) {
    return _items.values.elementAt(i);
  }
}
