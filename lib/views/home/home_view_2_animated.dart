import 'package:bgm/views/insulin/insulin_page.dart';
import 'package:bgm/views/meal/meal_page.dart';
import 'package:bgm/views/sleep/components/sleep_form.dart';
import 'package:bgm/views/sleep/sleep_page.dart';
import 'package:bgm/views/sport/sport_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView2Animated extends StatefulWidget {
  const HomeView2Animated({Key? key}) : super(key: key);

  @override
  State<HomeView2Animated> createState() => _HomeView2AnimatedState();
}

class _HomeView2AnimatedState extends State<HomeView2Animated> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // Number of pages (or tab views)
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("BGM"),
          //centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.notifications_none),
          //     onPressed: () {},
          //   ),
          //   IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {},
          //   )
          // ],
          // backgroundColor: Colors.purple,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.deepOrange],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          bottom: const TabBar(
            // isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(FontAwesomeIcons.bowlFood), text: 'Repas'),
              Tab(icon: Icon(FontAwesomeIcons.bed), text: 'Repos'),
              Tab(
                  icon: Icon(FontAwesomeIcons.personRunning),
                  text: 'Actvité physique'),
              Tab(icon: Icon(FontAwesomeIcons.syringe), text: 'Insuline'),
            ],
          ),
          elevation: 20,
          titleSpacing: 20,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 5,
          ),
          child: TabBarView(
            children: [
              MealPage(),
              SleepPage(),
              SportPage(),
              InsulinPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPage(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 28),
        ),
      );
}
