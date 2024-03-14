import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/registration/auth_gate.dart';
import 'package:chat_app/theme/dark_mode.dart';
import 'package:chat_app/theme/light_theme.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {



  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: darkMode,
      theme:isDarkMode? darkMode:lightMode ,
      home: const AuthGate(),
    );
  }
}
