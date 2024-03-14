import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key, required this.onToggle});

  final void Function(String) onToggle;

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  _register(context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final registerList = ref.watch(registerProvider);
      final authService = AuthService();
      try {
        await authService.signUpWithEmailPassword(
            registerList[0], registerList[1],registerList[2]);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
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
              hintText: 'Name',
              isObscure: false,
              identfier: 'name',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldClass(
              hintText: 'Email',
              isObscure: false,
              identfier: 'email',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldClass(
              hintText: 'Password',
              isObscure: true,
              identfier: 'password1',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldClass(
              hintText: 'Confirm Password',
              isObscure: true,
              identfier: 'password2',
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
                    _register(context);
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: Center(child: CircularProgressIndicator()))
                      : Text(
                          'Register',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.background),
                        ),
                ),
                const SizedBox(
                  width: 15,
                ),
                TextButton(
                    onPressed: () => widget.onToggle('login'),
                    child: const Text('have an account?'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
