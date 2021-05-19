import 'package:ecommerce/provider/repositories/login_repository.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  LoginRepository loginRepository;
  LoginProvider({@required this.loginRepository});

  Future<bool> login({@required String email, @required String password}) =>
      loginRepository.login(email: email, password: password);

  Future<bool> checkAlredyLogin() => loginRepository.checkAlredyLogin();
}
