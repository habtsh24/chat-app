import 'package:chat_app/provider/login_provider.dart';
import 'package:chat_app/provider/name_provider.dart';
import 'package:chat_app/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class TextFieldClass extends ConsumerWidget {
  TextFieldClass(
      {super.key,
      required this.hintText,
      required this.isObscure,
      required this.identfier});

  final String hintText;
  final bool isObscure;
  final String identfier;
  var input = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      obscureText: isObscure,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.primaryContainer,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none
          ),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide())),
      validator: (value) {
        if (value == null) {
          return 'Invalid input';
        }
        if (identfier == 'name') {
          return ref.read(registerProvider.notifier).nameValidator(value);
        } else if (identfier == 'email') {
          return ref.read(registerProvider.notifier).emailValidator(value);
        } else if (identfier == 'password1') {
          return ref.read(registerProvider.notifier).password1Validator(value);
        } else if (identfier == 'password2') {
          return ref.read(registerProvider.notifier).password2Validator(value);
        } else if (identfier == 'lemail') {
          return ref.read(loginProvider.notifier).emailChecker(value);
        } else if (identfier == 'lpassword') {
          return ref.read(loginProvider.notifier).passwordChecker(value);
        }
        else if (identfier == 'group') {
          return ref.read(NameProvider.notifier).nameValidator(value);
        }

        return null;
      },
    );
  }
}
