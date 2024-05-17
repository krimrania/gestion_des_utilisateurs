import 'package:flutter/material.dart';
import 'ViewUsers.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewUsers()),
            );
          },
          child: Text('Voir les utilisateurs'),
        ),
      ),
    );
  }
}
