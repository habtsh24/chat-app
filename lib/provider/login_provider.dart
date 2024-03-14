import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<List> {
  LoginNotifier() : super([]);

  String email = '';
  String password = '1234';

  emailChecker(String loginEmail) {
    if (loginEmail.isEmpty) {
      return 'email must be filled';
    }
    email = loginEmail;
    return null;
  }

  passwordChecker(String loginpassword) {
      password = loginpassword;
      state = [email,password];
      return null;
    } 
}

final loginProvider =
    StateNotifierProvider<LoginNotifier, List>((ref) => LoginNotifier());
