import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './aplicação/users.dart';
import './aplicação/user_form.dart';
import './aplicação/user_list.dart';

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
