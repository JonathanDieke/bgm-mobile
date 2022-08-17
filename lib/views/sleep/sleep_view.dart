import 'package:bgm/views/sleep/components/sleep_form.dart';
import 'package:flutter/material.dart';

import '../../utils/logo.dart';

class SleepView extends StatefulWidget {
  const SleepView({Key? key}) : super(key: key);

  @override
  State<SleepView> createState() => _SleepViewState();
}

class _SleepViewState extends State<SleepView> {
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
              SleepForm(),
            ],
          ),
        ),
      ),
    );
  }
}
