import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageView1 extends StatelessWidget {
  const PageView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: screenSize.height * 0.45,
          width: screenSize.width,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          // child: Image.asset("assets/images/slider.png"),
          child: SvgPicture.asset("assets/svg/glucosemeter.svg"),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 10,
          ),
          child: const Text(
            "Avec VOUS, nous souhaitons lutter contre les désastreux effets du diabètes",
            // "Avec vous, nous souhaitons lutter contre les conséquences du diabètes",
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Seravek",
            ),
          ),
        )
      ],
    );
  }
}
