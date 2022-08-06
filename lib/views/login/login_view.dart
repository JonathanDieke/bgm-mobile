import 'package:flutter/material.dart';

import '../../components/my_footer_component.dart';
import '../../utils/logo.dart';
import 'components/form_component.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      bottomSheet: const MyFooterComponent(),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: ListView(
          children: [
            //Header
            Container(
              height: screenSize.height * 0.2,
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  logo(height: screenSize.height*.08, width: screenSize.width*.1),
                    // logoMin(),
                    GestureDetector(
                      onTap: () async {
                        // SharedPreferences prefs =
                        //     await SharedPreferences.getInstance();
                        // if (prefs.getBool("userAttemptedConnection")) {
                        //   //Sortir de l'application
                        //   print('close app');
                        //   SystemChannels.platform
                        //       .invokeMethod('SystemNavigator.pop');
                        // } else {
                        //   Navigator.pushReplacementNamed(context, "/intro");
                        // }
                      },
                      child: const Icon(Icons.close,
                          size: 30, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            //Formulaire
            const FormComponent(),
          ],
        ),
      ),
    );
  }
}
