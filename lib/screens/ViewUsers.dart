import 'package:flutter/material.dart';
import 'package:gestion_des_utilisateurs/mod%C3%A8le/User.dart';
import 'package:gestion_des_utilisateurs/screens/AddUser.dart';
import 'package:gestion_des_utilisateurs/screens/EditUser.dart';
import 'package:gestion_des_utilisateurs/services/UserService.dart';

class ViewUsers extends StatefulWidget {
  @override
  _ViewUsersState createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  final UserService _userService = UserService();
  late Future<List<User>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = _userService.getUsers() as Future<List<User>>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des utilisateurs'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUser()),
              ).then((value) {
                setState(() {
                  _userList = _userService.getUsers() as Future<List<User>>;
                });
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _userList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun utilisateur trouvé.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.contact),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUser(user: user),
                            ),
                          ).then((value) {
                            setState(() {
                              _userList = _userService.getUsers() as Future<List<User>>;
                            });
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _userService.deleteUserById(user.id!).then((_) {
                            setState(() {
                              _userList = _userService.getUsers() as Future<List<User>>;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
