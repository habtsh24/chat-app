import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationNotifier extends StateNotifier<List<String>> {
  RegistrationNotifier() : super([]);
  String validName = '';
  String validEmail = '';
  String validPassword = '';

   nameValidator(String name) {
    if (name.isEmpty || name.trim().length < 2 || name.trim().length > 30) {
      return 'the name must be between 2 and 30 ';
    } else {
      for (int i = 0; i < name.length; i++) {
        if (int.tryParse(name[i]) != null) {
          return 'the name doesn\'t contain integer value';
        }
      }
      validName = name;
      return null;
    }
  }

  emailValidator(String email) {
    if (email.isEmpty) {
      return 'the email must be filled';
    } else if (!email.contains('@gmail.com')) {
      return 'invalid email address';
    } else {
      validEmail = email;
      return null;
    }
  }

  password1Validator(String password) {
    if (password.isEmpty || password.trim().length < 8) {
      return 'password length must be 8 or more';
    } else {
      validPassword = password;
      return null;
    }
  }

  password2Validator(String password) {
    if (password != validPassword) {
      return 'mis match password';
    } else {
      state =  [validEmail,validPassword,validName];
      return null;
    }
  }
}

final registerProvider =
    StateNotifierProvider<RegistrationNotifier, List<String>>(
        (ref) => RegistrationNotifier());
