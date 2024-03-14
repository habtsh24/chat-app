import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Settings();
  }
}

class _Settings extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        title: const Text('Dark Mode'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(children: [
          SwitchListTile(
      value:ref.read(themeProvider.notifier).isDarkMode ,
      onChanged: (value) {
        ref.read(themeProvider.notifier).toggleTheme(value);
      },
      title: const Text('Dark Mode'),
    ),
        ]),
      ),
    );
  }
}
