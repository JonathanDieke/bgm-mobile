import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealCard extends StatelessWidget {
  final String title;
  final bool status;
  const MealCard(this.title, this.status, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FaIcon(
                  status ? FontAwesomeIcons.check : FontAwesomeIcons.spinner,
                  size: 35,
                  color: status ?Colors.green[700] : Colors.deepOrange[700],
                ),
                SizedBox(
                  width: screenSize.width * .045,
                ),
                const FaIcon(
                  Icons.arrow_right_outlined,
                  size: 35,
                  color: Colors.black87,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
