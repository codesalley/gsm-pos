import 'package:gsm_pos/modal/modal.dart';

class AppBrain {
  Map total = {};

  User admin = User(name: 'Free-man', password: 'gsmdoctor2021');
  User appuser = User(name: 'admin', password: 'freeman');

  void validate({String username, String password}) {
    if (username == appuser.name && password == appuser.password) {
      print('Login successfully ');
    } else if (username == admin.name && password == admin.password) {
      print('Admin passed');
    }
  }
}
