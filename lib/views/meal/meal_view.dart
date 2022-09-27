import 'package:bgm/views/meal/components/meal_form.dart';
import 'package:bgm/views/meal/components/meal_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/logo.dart';

class MealView extends StatefulWidget {
  const MealView({Key? key}) : super(key: key);

  @override
  State<MealView> createState() => _MealViewState();
}

class _MealViewState extends State<MealView> {
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
              //Cards contenant les différents repas checked when done
              const MealCard(
                  "Petit déjeuner (entre 7h et 9h)", true),
              const MealCard(
                  "Déjeuner (entre 12h et 13h)", true),
              const MealCard(
                  "Diner (entre 18h et 20h)", true),
              //Divider
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: screenSize.width * .08,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              const MealForm(),
            ],
          ),
        ),
      ),
    );
  }
}
