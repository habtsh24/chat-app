import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/provider/name_provider.dart';
import 'package:chat_app/screens/main_screen/home_screen/group_chat.dart';
import 'package:chat_app/screens/main_screen/home_screen/individual_chat.dart';
import 'package:chat_app/screens/main_screen/setting.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/gourp_chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  onSave(context) async {
    if (_formKey.currentState!.validate()) {
      final groupName = ref.watch(NameProvider);
      final groupChatService = GroupChatService();
      final personId = _authService.getCurrentUser()!.uid;
      try {
        groupChatService.newGroup(groupName, personId, true);
      } catch (e) {
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

  _signout() {
    final auth = AuthService();
    auth.signOut();
  }

  void onToggle(String identifier) {
    if (identifier == 'home') {
      Navigator.pop(context);
    }
    if (identifier == 'setting') {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Settings()));
    }
    if (identifier == 'logout') {
      Navigator.pop(context);
      showDialog(
        
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('Do you want to logout?',style: TextStyle(fontSize: 16),),
          shape: const RoundedRectangleBorder(),
       
          actions: [
            TextButton(
                onPressed: () {
                  _signout();
                  Navigator.pop(context);
                },
                child: const Text('Ok')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'))
          ],
        ),
      );
    }
    if (identifier == 'createGroup') {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          titlePadding: const EdgeInsets.all(15),
          contentPadding: const EdgeInsets.all(15),
          shape: const RoundedRectangleBorder(),
          title: const Text('New Group'),
          children: [
            Form(
              key: _formKey,
              child: TextFieldClass(
                  hintText: 'group name', isObscure: false, identfier: 'group'),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  onPressed: () {
                    onSave(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'create',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'))
              ],
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTabs = <Tab>[
      Tab(
        icon: Icon(
          Icons.person,
          size: 35,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ),
      Tab(
        icon: Icon(
          Icons.group,
          size: 35,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      )
    ];

    final kTabsPages = <Widget>[const IndividualChat(), const GroupChat()];

    final String? email = _authService.getCurrentUser()!.displayName;
    return DefaultTabController(
      length: kTabs.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
          bottom: TabBar(
            tabs: kTabs,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Center(child: Text(email!)),
            )
          ],
        ),
        drawer: MyDrawer(
          onToggle: onToggle,
        ),
        body: TabBarView(
          children: kTabsPages,
        ),
      ),
    );
  }
}
