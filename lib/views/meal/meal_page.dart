import 'package:bgm/views/meal/components/meal_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/meal_form.dart';

class MealPage extends StatefulWidget {
  MealPage({Key? key}) : super(key: key);

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: ListView(
        children: [
          //Cards contenant les différents repas checked when done
          const MealCard(
              "Petit déjeuner (entre 7h et 9h)", FontAwesomeIcons.check),
          const MealCard("Déjeuner (entre 12h et 13h)", FontAwesomeIcons.check),
          const MealCard("Diner (entre 18h et 20h)", FontAwesomeIcons.check),
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
    );
  }
}