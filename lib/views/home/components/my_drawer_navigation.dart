import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../api/providers/user_provider.dart';
import '../../../components/my_dialog_box.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';

class MyDrawerNavigation extends StatefulWidget {
  MyDrawerNavigation({Key? key}) : super(key: key);

  @override
  State<MyDrawerNavigation> createState() => _MyDrawerNavigationState();
}

class _MyDrawerNavigationState extends State<MyDrawerNavigation> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  String pseudo = 'pseudo';
  String id = 'id';

  @override
  void initState() {
    super.initState();
    dynamic user = UserProvider.getUser();
    pseudo = user["userPseudo"];
    // pseudo.split('-')
    id = user["userId"];
  }

  @override
  Widget build(BuildContext context) {
    const urlImage =
        'https://media.defense.gov/2020/Feb/19/2002251686/-1/-1/0/200219-A-QY194-002.JPG';
    // 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepOrange],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        // color: Colors.deepOrange.withOpacity(0.65),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              pseudo: pseudo,
              id: id,
              onClicked: () => print('ok'),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // buildHomeItem(),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Accueil',
                    icon: Icons.home_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Mon profil',
                    icon: Icons.person_outline_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.shade700, height: 20),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Déconnexion',
                    icon: Icons.logout_outlined,
                    onClicked: () => selectedItem(context, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String pseudo,
    required String id,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(
            const EdgeInsets.only(
              top: 40,
              bottom: 20,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pseudo,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    id,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
              // Spacer(),
              // CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
              // )
            ],
          ),
        ),
      );

  Widget buildHomeItem() {
    const color = Colors.white;

    return TextField(
      style: const TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Accueil',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(Icons.home_outlined, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, "/profile");
        break;
      case 2:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Déconnexion",
              description: "Voulez-vous vraiment vous déconnecter ?",
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Annuler',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      UserProvider.logout();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      'Confirmer',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );

        break;
    }
  }
}
