import 'package:bgm/views/insulin/components/insulin_form.dart';
import 'package:flutter/material.dart';

import '../../utils/logo.dart';

class InsulinView extends StatefulWidget {
  const InsulinView({Key? key}) : super(key: key);

  @override
  State<InsulinView> createState() => _InsulinViewState();
}

class _InsulinViewState extends State<InsulinView> {
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
              const InsulinFormComponent(),
            ],
          ),
        ),
      ),
    );
  }
}