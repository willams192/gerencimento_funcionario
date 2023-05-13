import 'package:flutter/material.dart';
import './users.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
                        Navigator.of(context).pushNamed(
                          AppRoutes.USER_FORM,
                          arguments: users.byIndex(i),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        Provider.of<Users>(context, listen: false)
                            .remove(users.byIndex(i));
                      },
                    ),
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
