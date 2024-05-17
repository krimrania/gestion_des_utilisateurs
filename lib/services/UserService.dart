import 'package:gestion_des_utilisateurs/db_helper/repository.dart';
import 'package:gestion_des_utilisateurs/mod%C3%A8le/User.dart';

class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

  saveUser(User user) async {
    return await _repository.insertData('users', user.toMap());
  }

  readAllUsers() async {
    return await _repository.readData('users');
  }

  updateUser(User user) async {
    return await _repository.updateData('users', user.toMap());
  }

  deleteUser(int userId) async {
    return await _repository.deleteData('users', userId);
  }
}
