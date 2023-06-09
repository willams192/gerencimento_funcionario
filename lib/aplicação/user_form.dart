import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'api.dart';
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
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
    _formData['cargo'] = user.cargo;
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
        final name = _formData['name'];
        final email = _formData['email'];
        final avatarUrl = _formData['avatarUrl'];
        final cargo = _formData['cargo'];

        if (name != null &&
            email != null &&
            avatarUrl != null &&
            cargo != null) {
          final user = ModalRoute.of(context)?.settings.arguments as User?;

          if (user != null) {
            // Código para atualizar o usuário existente
            final url = '${Api.url}/funcionario/update/${user.id}';
            final response = await http.put(
              Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: json.encode({
                'name': name,
                'email': email,
                'avatarUrl': avatarUrl,
                'cargo': cargo,
              }),
            );

            if (response.statusCode == 200) {
              final updatedUser = User(
                id: user.id,
                name: name,
                email: email,
                avatarUrl: avatarUrl,
                cargo: cargo,
              );
              Provider.of<Users>(context, listen: false).put(updatedUser);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Funcionário atualizado com sucesso!'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro ao atualizar funcionário.'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            Navigator.of(context).pop();
          } else {
            // Código para adicionar um novo usuário
            final url = '${Api.url}/funcionario/add';
            final response = await http.post(
              Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: json.encode({
                'name': name,
                'email': email,
                'avatarUrl': avatarUrl,
                'cargo': cargo,
              }),
            );

            if (response.statusCode == 200) {
              final responseData = json.decode(response.body);
              final newUserId =
                  responseData != null ? responseData['_id'] : null;
              final newUser = User(
                id: newUserId ?? _uuid.v4(),
                name: name,
                email: email,
                avatarUrl: avatarUrl,
                cargo: cargo,
              );

              Provider.of<Users>(context, listen: false).put(newUser);
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

            Navigator.of(context).pop();
          }
        }
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
          ),
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
                  final emailRegex =
                      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                  if (!emailRegex.hasMatch(value)) {
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
              TextFormField(
                initialValue: _formData['cargo'],
                decoration: InputDecoration(labelText: 'Cargo'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Cargo inválido';
                  }
                  return null;
                },
                onSaved: (value) => _formData['cargo'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
