import 'package:flutter/material.dart';
import 'package:gestion_des_utilisateurs/db_helper/repository.dart';
import 'package:gestion_des_utilisateurs/mod%C3%A8le/User.dart';

class EditUser extends StatefulWidget {
  final User user;

  EditUser({required this.user});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _contactController = TextEditingController(text: widget.user.contact);
    _descriptionController = TextEditingController(text: widget.user.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateUser() {
    User updatedUser = User(
      id: widget.user.id,
      name: _nameController.text,
      contact: _contactController.text,
      description: _descriptionController.text,
    );

    Repository().updateData('users', updatedUser.toMap());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(labelText: 'Contact'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateUser,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
