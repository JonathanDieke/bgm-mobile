import 'package:bgm/views/home/components/daily_data_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:provider/provider.dart';

import '../../api/providers/daily_data_provider.dart';
import '../../utils/logo.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: ListView(
            children: [
              //Header
              Container(
                height: screenSize.height * .1,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      logo(
                        height: screenSize.height * .06,
                        width: screenSize.width * .08,
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  //Curve space
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(
                        color: const Color.fromARGB(0, 179, 10, 10),
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                          screenSize.width,
                          200.0,
                        ),
                      ),
                    ),
                    height: screenSize.height * .1,
                    width: screenSize.width,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .025,
                    ),
                    child: FutureBuilder(
                        future: DailyDataProvider.initialize(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  //Créer une daily data
                                  DailyDataForm(),
                                  // 4 cards : Repas, Sommeil, Activité sportive, Prise d'insuline
                                  GridView.count(
                                    shrinkWrap: true,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    primary: false,
                                    children: <Widget>[
                                      homeCard("Ajouter un repas",
                                          FontAwesomeIcons.bowlFood, "/meal"),
                                      homeCard("Ajouter un temps de sommeil",
                                          FontAwesomeIcons.bed, "/meal"),
                                      homeCard(
                                          "Ajouter une activité physique",
                                          FontAwesomeIcons.personRunning,
                                          "/meal"),
                                      homeCard("Ajouter une prise d'insuline",
                                          FontAwesomeIcons.syringe, "/meal"),
                                    ],
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Une erreur est survenue : ${snapshot.error}. \n Veuillez conatcter le service support.',
                                ),
                              );
                            }
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  homeCard(String title, IconData icon, String attachedView) {
    return Consumer<DailyDataProvider>(
      builder: (ontext, dailyDataProvider, child) {
        return dailyDataProvider.isForCurrentDay()
            ? Card(
                elevation: 2,
                margin: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: const LinearGradient(
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(3.0, -1.0),
                      colors: [
                        Color(0xFFffffff),
                        Color.fromARGB(255, 224, 86, 93),
                        Color(0xFFffffff),
                      ],
                    ),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.white,
                    //     blurRadius: 3,
                    //     offset: Offset(2, 2),
                    //   )
                    // ],
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, attachedView);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        const SizedBox(height: 50),
                        Center(
                          child: IconButton(
                            icon: FaIcon(
                              icon,
                              size: 100,
                            ),
                            onPressed: () {
                              print("Pressed icon on home view");
                              Navigator.pushNamed(context, attachedView);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }

// fin
}
