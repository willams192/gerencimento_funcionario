import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Gerenciador de usuarios/users.dart';
import 'Formulario/user_form.dart';
import '../Lista de usuarios/user_list.dart';

class AppRoutes {
  static const USER_FORM = '/user-form';
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Users(),
        ),
      ],
      child: MaterialApp(
        title: 'Gerenciador de Funcionários',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserList(),
        routes: {
          AppRoutes.USER_FORM: (_) => UserForm(),
        },
      ),
    );
  }
}
