import 'package:bgm/views/home/components/my_drawer_navigation.dart';
import 'package:bgm/views/insulin/insulin_page.dart';
import 'package:bgm/views/meal/meal_page.dart';
import 'package:bgm/views/sleep/sleep_page.dart';
import 'package:bgm/views/sport/sport_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/daily_data_form.dart';

class HomeView2Animated extends StatefulWidget {
  const HomeView2Animated({Key? key}) : super(key: key);

  @override
  State<HomeView2Animated> createState() => _HomeView2AnimatedState();
}

class _HomeView2AnimatedState extends State<HomeView2Animated> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      // Number of pages (or tab views)
      length: 5,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawerNavigation(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("BGM"),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              _scaffoldKey.currentState?.openDrawer();
            },
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
          bottom: TabBar(
            onTap: (int index) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            isScrollable: screenSize.width < 460 ? true : false,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: const [
              Tab(icon: Icon(FontAwesomeIcons.person), text: 'Etat physique'),
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
              DailyDataForm(),
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
