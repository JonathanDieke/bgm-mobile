import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageView3 extends StatelessWidget {
  const PageView3({Key? key}) : super(key: key);

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
          child: SvgPicture.asset("assets/svg/science.svg"),
        ),
        Container(
          child: const Text(
            'Merci de partager vos données avec le monde de la science !',
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
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
