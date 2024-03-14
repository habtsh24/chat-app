import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeProvider extends ChangeNotifier {

  final myBox = Hive.box('mybox');

  bool get isDarkMode => myBox.get('key') ?? false;

  void toggleTheme(bool isDarkMode) {
    myBox.put('key', isDarkMode);
    notifyListeners();
  }
}
final themeProvider = ChangeNotifierProvider((ref) => ThemeProvider());