import 'package:flutter/material.dart';
import 'package:gestion_des_utilisateurs/mod%C3%A8le/User.dart';
import 'package:gestion_des_utilisateurs/services/UserService.dart';

class AddUser extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final UserService _userService = UserService();

  void _saveUser(BuildContext context) async {
    User user = User(
      name: _nameController.text,
      contact: _contactController.text,
      description: _descriptionController.text,
    );
    await _userService.saveUser(user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(labelText: 'Contact'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un contact';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _contactController.text.isNotEmpty) {
                  _saveUser(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Veuillez remplir tous les champs'),
                    ),
                  );
                }
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
