import 'package:flutter_riverpod/flutter_riverpod.dart';

class NameNotifier extends StateNotifier<String> {
  NameNotifier() : super('');

  nameValidator(String name) {
    if (name.isEmpty || name.trim().length < 2 || name.trim().length > 30) {
      return 'the name must be between 2 and 30 ';
    } else {
      state = name;
      return null;
    }
  }
}

final NameProvider = StateNotifierProvider<NameNotifier,String>((ref) => NameNotifier());
