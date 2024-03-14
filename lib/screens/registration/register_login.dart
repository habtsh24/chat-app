import 'package:chat_app/screens/registration/login.dart';
import 'package:chat_app/screens/registration/register.dart';
import 'package:flutter/material.dart';

class RegisterLogin extends StatefulWidget {
  const RegisterLogin({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterLogin();
  }
}

class _RegisterLogin extends State<RegisterLogin> {
  bool isLoginActive = true;
  String activeScreenCheckerString = 'login';

  void screenChecker(String identifier) {
    setState(() {
      activeScreenCheckerString = identifier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return activeScreenCheckerString == 'login'
        ? Login(onToggle: screenChecker)
        : Register(onToggle: screenChecker);
  }
}
