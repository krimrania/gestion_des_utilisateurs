import 'package:gestion_des_utilisateurs/db_helper/database_connection.dart';
import 'package:gestion_des_utilisateurs/db_helper/repository.dart';
import 'package:gestion_des_utilisateurs/mod%C3%A8le/User.dart';

class UserService {
  final Repository _repository;

  UserService()
      : _repository = Repository(DatabaseConnection());

  // Méthode pour ajouter un utilisateur
  Future<void> addUser(User user) async {
    await _repository.insertData('users', user.toMap());
  }

  // Méthode pour obtenir tous les utilisateurs
  Future<List<Future<User?>>> getUsers() async {
    List<Map<String, dynamic>> userMaps = await _repository.readData('users');
    return userMaps.map((userMap) => User.fromMap(userMap)).toList();
  }

  // Méthode pour obtenir un utilisateur par ID
  Future<User?> getUserById(int id) async {
    Map<String, dynamic>? userMap = await _repository.readDataById('users', id);
    if (userMap != null) {
      return User.fromMap(userMap);
    }
    return null;
  }

  // Méthode pour mettre à jour un utilisateur
  Future<void> updateUser(User user) async {
    await _repository.updateData('users', user.toMap());
  }

  // Méthode pour supprimer un utilisateur par ID
  Future<void> deleteUserById(int id) async {
    await _repository.deleteDataById('users', id);
  }
}
