import 'package:flutter/material.dart';

// import 'profile_avatar.dart';

AppBar buildProfileAppBar(BuildContext context, ) {
  return AppBar(
    title: const Text('Editer mon profil'),
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.deepOrange],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
    ), 
    actions: const [
      // Icon(Icons.save_as_outlined, size: 40), 
      // ThemeSwitcher(
      //   builder: (context) => IconButton(
      //     icon: Icon(icon),
      //     onPressed: () {
      //       final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;

      //       final switcher = ThemeSwitcher.of(context)!;
      //       switcher.changeTheme(theme: theme);
      //     },
      //   ),
      // ),
    ],
  );
}
