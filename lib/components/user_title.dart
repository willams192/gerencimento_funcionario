import 'package:flutter_crud/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';


class UserTile extends StatelessWidget{
  
  final User? user;

const UserTile(
    this.user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final avatar = user!.avatarurl == null || user!.avatarurl.isEmpty
      ? const CircleAvatar(child: Icon(Icons.person))
      : CircleAvatar(backgroundImage: NetworkImage(user!.avatarurl));
   return ListTile(
      leading: avatar,
      title: Text(user!.name),
      subtitle: Text(user!.email),
      trailing: 
      SizedBox(
       width: 100,
       child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              }, 
            ),
              IconButton(
              icon: Icon(Icons.delete),
              color: Colors.black,
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: ((context) => AlertDialog(
                      title:Text ('Excluir usuário') ,
                      content: Text('Quer excluir mesmo o usuário?'),
                      actions: <Widget> [
                          FloatingActionButton.small(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },    
                            child: Text('Não'),
                          ),
                          FloatingActionButton.small(
                            onPressed: () {
                             Provider.of<Users>(context, listen: false).remove(user!);
                             Navigator.of(context).pop();
                            },
                            child: Text('Sim'),
                          ),
                       ],
                      )
                   ),
                );
              }, 
            ),
          ],
        ),
      ),
   );
  }
}