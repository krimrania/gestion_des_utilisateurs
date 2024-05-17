import 'package:flutter/material.dart';
import 'package:gestion_des_utilisateurs/screens/AddUser.dart';
import 'package:gestion_des_utilisateurs/screens/ViewUsers.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Utilisateurs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Ajouter un Utilisateur'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUser()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Voir les Utilisateurs'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewUsers()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
