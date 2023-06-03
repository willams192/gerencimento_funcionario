import 'package:flutter/material.dart';
import './users.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'api.dart';
import 'user.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  // Variável para armazenar o usuário a ser excluído
  User? _userToDelete;

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(users.byIndex(i).avatarUrl),
              ),
              title: Text(users.byIndex(i).name),
              subtitle: Text(users.byIndex(i).email),
              trailing: Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.USER_FORM,
                            arguments: users.byIndex(i));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        // Define o usuário a ser excluído
                        _userToDelete = users.byIndex(i);
                        // Abre o modal de confirmação
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Confirmar Exclusão'),
                            content: Text(
                              'Deseja realmente excluir o usuário ${_userToDelete!.name}?',
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  // Fecha o modal de confirmação
                                  Navigator.of(ctx).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Excluir'),
                                onPressed: () async {
                                  try {
                                    final userId = _userToDelete!.id;
                                    await Api.removeUser(userId);
                                    users.remove(_userToDelete!);
                                    // Fecha o modal de confirmação
                                    Navigator.of(ctx).pop();
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.USER_FORM);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
