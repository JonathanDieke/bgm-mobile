import 'package:flutter/material.dart';

// import 'profile_avatar.dart';

AppBar buildAppBar(BuildContext context) {
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
    // bottom: const TabBar(
    //   indicatorWeight: 1,
    //   tabs: [
    //     ProfileAvatar(
    //       imagePath:
    //           'https://media.defense.gov/2020/Feb/19/2002251686/-1/-1/0/200219-A-QY194-002.JPG',
    //     ),
    //   ],
    // ),
    actions: const [
      // Icon(icon),
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
