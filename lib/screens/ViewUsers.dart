import 'package:flutter/material.dart';
import 'package:gestion_des_utilisateurs/mod%C3%A8le/User.dart';
import 'package:gestion_des_utilisateurs/services/UserService.dart';

class ViewUsers extends StatefulWidget {
  @override
  _ViewUsersState createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  final UserService _userService = UserService();
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  _loadUsers() async {
    var users = await _userService.readAllUsers();
    setState(() {
      _users = users.map<User>((data) {
        return User(
          id: data['id'],
          name: data['name'],
          contact: data['contact'],
          description: data['description'],
        );
      }).toList();
    });
  }

  _deleteUser(int userId) async {
    await _userService.deleteUser(userId);
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold 
    (
      appBar: AppBar(
        title: Text('Liste des Utilisateurs'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          User user = _users[index];
          return ListTile(
            title: Text(user.name!),
            subtitle: Text(user.contact!),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteUser(user.id!);
              },
            ),
          );
        },
      ),
    );
  }
}

