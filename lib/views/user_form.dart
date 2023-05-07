import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/users.dart';

class UserForm extends StatefulWidget {
  UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  bool isEmailValid(String? email) {
    // Verifica se o email é nulo ou vazio
    if (email == null || email.isEmpty) {
      return false;
    }

    // Verifica se o email é válido utilizando uma expressão regular
    final emailRegex =
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    return emailRegex.hasMatch(email);
  }

  Future<void> submitForm() async {
    final isValid = _form.currentState?.validate() ?? false;
    if (isValid) {
      _form.currentState?.save();
      final user = User(
        id: _formData['id']!,
        name: _formData['name']!,
        email: _formData['email']!,
        avatarurl: _formData['avatarurl']!,
      );
      final response = await http.post(
        Uri.parse('http://localhost:3000/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'avatarurl': user.avatarurl,
        }),
      );
      if (response.statusCode == 201) {
        Navigator.of(context).pop();
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Ocorreu um erro!'),
            content: Text('Erro ${response.statusCode}: ${response.body}'),
            actions: <Widget>[
              TextButton(
                child: Text('Fechar'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      }
    }
  }

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarurl'] = user.avatarurl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = ModalRoute.of(context)?.settings.arguments as User;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final valido = _form.currentState?.validate() ?? false;
              if (valido) {
                _form.currentState?.save();
                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id']!,
                    name: _formData['name']!,
                    email: _formData['email']!,
                    avatarurl: _formData['avatarurl']!,
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Insira o nome';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                  initialValue: _formData['email'],
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (!isEmailValid(value)) {
                      return 'Insira um e-mail válido';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['email'] = value!),
              TextFormField(
                  initialValue: _formData['avatarurl'],
                  decoration: InputDecoration(labelText: 'URL do Avatar'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Insira uma URL';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['avatarurl'] = value!),
            ],
          ),
        ),
      ),
    );
  }
}
