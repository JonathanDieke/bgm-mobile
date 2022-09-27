import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../api/providers/user_provider.dart';
import '../../../utils/helpers.dart';

class LoginFormComponent extends StatefulWidget {
  const LoginFormComponent({Key? key}) : super(key: key);

  @override
  State<LoginFormComponent> createState() => _FormComponentState();
}

class _FormComponentState extends State<LoginFormComponent> {
  TextEditingController loginTextController =
      TextEditingController(text: '');
  TextEditingController pwdTextController =
      TextEditingController(text: '');

  bool isRememberMe = false,
      isAttemptLogin = false,
      isObscurePswd = true,
      isErrorLoginTextField = false,
      isErrorPwdTextField = false;
  String errorMessage = 'Ce champ est requis';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        // color: Colors.deepOrange,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Login Text
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  'Se Connecter'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              //Afficher les erreurs
              isErrorLoginTextField
                  ? Text(
                      errorMessage,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.red.shade700),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              // Pseudo
              Container(
                height: screenSize.height * 0.066,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(13, 13)),
                  border: Border.all(
                    color: isErrorLoginTextField
                        ? Colors.red.shade700
                        : Colors.grey.shade300,
                    style: BorderStyle.solid,
                  ),
                ),
                child: TextField(
                  controller: loginTextController,
                  autocorrect: true,
                  onChanged: (String value) {
                    setState(() {
                      isErrorLoginTextField = false;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: "Pseudo",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: "Arial",
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //Password
              //Afficher les erreurs
              isErrorPwdTextField
                  ? Text(
                      errorMessage,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.red.shade700),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              Container(
                height: screenSize.height * 0.066,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isErrorPwdTextField
                        ? Colors.red.shade700
                        : Colors.grey.shade300,
                    style: BorderStyle.solid,
                  ),
                ),
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      isErrorPwdTextField = false;
                    });
                  },
                  controller: pwdTextController,
                  autocorrect: true,
                  obscureText: isObscurePswd,
                  decoration: InputDecoration(
                      suffix: GestureDetector(
                        child: (isObscurePswd)
                            ? const Icon(
                                FontAwesomeIcons.solidEye,
                                color: Colors.black,
                                size: 20,
                              )
                            : const Icon(
                                FontAwesomeIcons.eyeSlash,
                                color: Colors.black,
                                size: 20,
                              ),
                        onTap: () {
                          setState(() {
                            // if (isObscurePswd == true) {
                            isObscurePswd = !isObscurePswd;
                            // } else {
                            // isObscurePswd = true
                            // }
                          });
                        },
                      ),
                      hintText: "Mot de passe",
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Arial",
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Bouton de connexion + se souvenir de moi
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row(
                  //   children: [
                  //     //Se souvenir de moi
                  //     Checkbox(
                  //       value: isRememberMe,
                  //       activeColor: Colors.grey.shade300,
                  //       checkColor: Colors.green,
                  //       // focusColor: Colors.amber,
                  //       // hoverColor: Colors.red,
                  //       onChanged: (bool? value) {
                  //         setState(() {
                  //           isRememberMe = value!;
                  //         });
                  //       },
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           isRememberMe = !isRememberMe;
                  //         });
                  //       },
                  //       child: const Text(
                  //         "Se souvenir de moi",
                  //         style: TextStyle(
                  //           fontFamily: "Montserrat",
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 25),
                  //Bouton de connexion
                  Container(
                    constraints: BoxConstraints(
                      minWidth: screenSize.width,
                      minHeight: 50.0,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(10, 10),
                      ),
                    ),
                    child: !isAttemptLogin
                        // ignore: deprecated_member_use
                        ? RaisedButton(
                            onPressed: () {
                              attemptLogin();
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.elliptical(10, 10),
                              ),
                            ),
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.elliptical(10, 10),
                                ),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                  minWidth: screenSize.width,
                                  minHeight: 50.0,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Connexion",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                              ),
                              child: const CircularProgressIndicator(
                                backgroundColor: Colors.green,
                                strokeWidth: 5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  attemptLogin() async {
    // Navigator.pushReplacementNamed(context, "/home");

    if (loginTextController.text.isEmpty || pwdTextController.text.isEmpty) {
      //
      if (loginTextController.text.isEmpty) {
        setState(() {
          isErrorLoginTextField = true;
        });
      }

      if (pwdTextController.text.isEmpty) {
        setState(() {
          isErrorPwdTextField = true;
        });
      }
      // this._showSnackbar('Veuillez remplir tous les champs !',
      //     removePwd: false);
    } else {
      setState(() {
        isAttemptLogin = true;
      });

      UserProvider authProvider =
          Provider.of<UserProvider>(context, listen: false);

      authProvider
          .authenticate(loginTextController.text, pwdTextController.text)
          .then((Map<String, dynamic> data) {
        // print("result : ${data['result']}");

        setState(() {
          isAttemptLogin = false;
        });

        if (data['result']) {
          Navigator.pushReplacementNamed(context, "/home");
        } else {
          showSnackbar(context, data['message'], removePwd: false);
        }
      }).onError((error, stackTrace) {
        print("---- ERROR --- : " + error.toString());
        setState(() {
          isAttemptLogin = false;
        });

        showSnackbar(context,
            "Quelque chose s'est mal passé : veuilez réessayer ! Si le problème persiste, contactez le service support",
            duration: 5000);
      });
    }

    //
  }

  // _showSnackbar(String message, {bool removePwd = true, int duration = 3000}) {
  //   final snackBar = SnackBar(
  //     backgroundColor: Colors.grey[400],
  //     duration: Duration(milliseconds: duration),
  //     elevation: 4,
  //     content: Text(
  //       message,
  //       textAlign: TextAlign.center,
  //       style: const TextStyle(color: Colors.black, ),
  //     ),
  //     action: SnackBarAction(
  //       label: 'OK',
  //       textColor: Colors.black,
  //       onPressed: () {
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       },
  //     ),
  //   );

  //   if (removePwd) {
  //     // pwdTextController.text = "";
  //   }

  //   // Find the ScaffoldMessenger in the widget tree
  //   // and use it to show a SnackBar.
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  // fin : Make with love, by JonathanDieke
}
