import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key, required this.onToggle});

  final void Function(String) onToggle;

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  
  _login(context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final logedin = ref.watch(loginProvider);
      final authService = AuthService();
      try {
        await authService.signInWithEmailPassword(logedin[0], logedin[1]);
      } catch (e) {
        setState(() {
          isLoading = false;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 150,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldClass(
              hintText: 'Email',
              isObscure: false,
              identfier: 'lemail',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldClass(
              hintText: 'Password',
              isObscure: true,
              identfier: 'lpassword',
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  onPressed: () {
                    _login(context);
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: Center(child: CircularProgressIndicator()))
                      : Text(
                          'Login',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.background),
                        ),
                ),
                const SizedBox(
                  width: 15,
                ),
                TextButton(
                    onPressed: () => widget.onToggle('register'),
                    child: const Text('don\'t have an account?'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
