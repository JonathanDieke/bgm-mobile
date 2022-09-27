import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/providers/user_provider.dart';
import '../../components/my_footer_component.dart';
import '../../utils/logo.dart';
import 'components/login_form_component.dart';

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
                    logo(
                        height: screenSize.height * .08,
                        width: screenSize.width * .1, ),
                    // logoMin(),
                    Text(
                      'BGM Mobile',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (UserProvider.prefs
                                .getBool("userAttemptedConnection") ==
                            true) {
                          //Sortir de l'application
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        } else {
                          Navigator.pushReplacementNamed(context, "/intro");
                        }
                      },
                      child: const Icon(Icons.close,
                          size: 30, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Heureux de vous retrouver !',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      fontFamily: "IBMPlexSans",
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    'Veuillez entrer vos identifiants de connexion ci-dessous.',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.99),
                      fontSize: 18,
                      // fontWeight: FontWeight.w700,
                      // fontFamily: "IBMPlexSans",
                      // fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            //Formulaire
            const LoginFormComponent(),
          ],
        ),
      ),
    );
  }
}
