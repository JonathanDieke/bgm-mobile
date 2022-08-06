import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageView2 extends StatelessWidget {
  const PageView2({Key? key}) : super(key: key);

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
          child: Image.asset("assets/images/slider.png"),
        ),
        Container(
          child: const Text(
            'Grâce à l\'intelligence artificielle et ses possibilités, nous croyons y arriver',
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
