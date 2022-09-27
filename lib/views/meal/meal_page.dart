import 'package:bgm/api/providers/meal_provider.dart';
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

    // print("\n\n\n\n\n ${MealProvider.isTodayMealType('dinner')} \n\n\n");

    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: ListView(
        children: [
          //Cards contenant les différents repas checked when done
          MealCard("Petit déjeuner (7h ~ 9h)",
              MealProvider.isTodayMealType('first_breakfast')),
          MealCard("Déjeuner (12h ~ 13h)",
              MealProvider.isTodayMealType('breakfast')),
          MealCard(
            "Diner (18h ~ 20h)",
            MealProvider.isTodayMealType('dinner'),
          ),
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
