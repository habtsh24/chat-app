import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key,required this.onToggle});

  final void Function(String) onToggle;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
            child: Center(
          child: Icon(
            Icons.message,
            size: 50,
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            onTap: () => onToggle('home'),
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            title: const Text('H O M E'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            onTap: () => onToggle('setting'),
            leading: Icon(
              
              Icons.settings,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            title: const Text('S E T T I N G'),
          ),
        ), 
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            onTap: () => onToggle('createGroup'),
            leading: Icon(
              Icons.group,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            title: const Text('C R E A T  G R O U P'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            onTap: () => onToggle('logout'),
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            title: const Text('L O G O U T'),
          ),
        ),
      
      ]),
    );
  }
}
