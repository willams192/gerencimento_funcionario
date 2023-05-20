import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'users.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  final _uuid = Uuid();

  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    final user = route != null ? route.settings.arguments as User? : null;

    if (user != null) {
      _loadFormData(user);
    }
  }

  void _saveForm() async {
    if (_form.currentState != null) {
      final isValid = _form.currentState!.validate();
      if (isValid) {
        _form.currentState!.save();
        final id = _formData['id'] ?? _uuid.v4();
        final name = _formData['name'];
        final email = _formData['email'];
        final avatarUrl = _formData['avatarUrl'];

        if (id != null && name != null && email != null && avatarUrl != null) {
          final url =
              'http://192.168.0.100:3000/funcionario/add'; // Trocar o número do IP
          final response = await http.post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'id': id,
              'name': name,
              'email': email,
              'avatarUrl': avatarUrl,
            }),
          );
          if (response.statusCode == 200) {
            Provider.of<Users>(context, listen: false).put(User(
              id: id,
              name: name,
              email: email,
              avatarUrl: avatarUrl,
            ));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Funcionário salvo com sucesso!'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Erro ao salvar funcionário.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Funcionário'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome inválido';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome deve ter no mínimo 3 letras';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'E-mail inválido';
                  }
                  if (!value.contains('@')) {
                    return 'Informe um e-mail válido';
                  }
                  return null;
                },
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
