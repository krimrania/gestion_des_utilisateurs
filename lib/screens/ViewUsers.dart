import 'package:flutter/material.dart';
import 'package:gestion_des_utilisateurs/mod%C3%A8le/User.dart';
import 'package:gestion_des_utilisateurs/services/UserService.dart';

class ViewUsersScreen extends StatefulWidget {
  const ViewUsersScreen({Key? key}) : super(key: key);

  @override
  _ViewUsersScreenState createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  final UserService _userService = UserService();
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = _loadUsers();
  }

  Future<List<User>> _loadUsers() async {
    return _userService.readAllUsers();
  }

  void _deleteUser(int userId) async {
    await _userService.deleteUser(userId);
    setState(() {
      _futureUsers = _loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Utilisateurs'),
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Une erreur s\'est produite.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun utilisateur trouvé.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
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
            );
          }
        },
      ),
    );
  }
}
