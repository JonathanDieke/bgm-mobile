import 'package:bgm/views/sport/components/sport_form.dart';
import 'package:flutter/material.dart';

import '../../utils/logo.dart';

class SportView extends StatefulWidget {
  const SportView({Key? key}) : super(key: key);

  @override
  State<SportView> createState() => _SportViewState();
}

class _SportViewState extends State<SportView> {
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

              //Form
              SportFormComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
