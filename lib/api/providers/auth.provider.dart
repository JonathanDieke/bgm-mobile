import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User user = User();
  late SharedPreferences prefs;

  Future<Map<String, dynamic>> authenticate(String email, String password,
      {dynamic isRememberMe}) async {
    Map<String, dynamic> data = {
      'pseudo': "admin",
      'password': "password",
      // "remember": isRememberMe ? 1 : 0,
    };
    Uri uri = Uri.parse(Constants.logInURL);
    bool result = false;
    String message = '';

    prefs = await SharedPreferences.getInstance();
    prefs.setBool("userAttemptedConnection", true);

    var responseAPI = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(data),
    );

    // print(Constants.logInURL);

    if (responseAPI.statusCode == 200) {
      var data = json.decode(responseAPI.body);

      // print("data : ${data.toString()}");

      user = User.fromJson(data['user'], data['token']);

      setSession(user);

      result = true;
    } else {
      message = json.decode(responseAPI.body)["message"];
    }

    return <String, dynamic>{"result": result, "message": message};
  }

  // Future<String> getUserStatus() async {
  //   prefs = await SharedPreferences.getInstance();

  //   if (prefs.getBool("userAttemptedConnection") == null) {
  //     //première ouverture de l'app
  //     prefs.setBool("userAttemptedConnection", false);
  //     return 'intro';
  //   } else {
  //     if (prefs.getBool("userAttemptedConnection") == false) {
  //       //jamais essayé de s'authentifier
  //       return 'intro';
  //     } else {
  //       // déja essayé de s'authentifier
  //       if (prefs.getString("userToken") != null &&
  //           prefs.getString("userToken").isNotEmpty) {
  //         //déjà authentifié
  //         return 'home';
  //       }
  //       // non auth
  //       return "login";
  //     }
  //   }
  // }

  String? getToken() {
    return prefs.getString("userToken");
  }

  // Future<void> setUserProfileInfo() async {
  //   if (user.id.isEmpty ||
  //       user.name.isEmpty ||
  //       user.email.isEmpty ||
  //       user.token.isEmpty) {
  //     prefs = await SharedPreferences.getInstance();
  //   }

  //   user.id = (user.id.isNotEmpty ? user.id : prefs.getString("userEmail"))!;
  // }

  // Future<void> unsetSession() async {
  //   prefs = await SharedPreferences.getInstance();
  //   String token = "Bearer " + prefs.getString("userToken");

  //   await http.get(
  //     Uri.parse(Constants.LOG_OUT_URL),
  //     headers: {"Authorization": token},
  //   );
  //   prefs.clear();
  // }

  setSession(User user) async {
    prefs = await SharedPreferences.getInstance();

    prefs.setString('userId', user.id);
    prefs.setString('userPseudo', user.pseudo);
    prefs.setString('userToken', user.token);
  }

  //fin : Make with love, by JonathanDieke
}
