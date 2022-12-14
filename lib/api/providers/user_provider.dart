import 'dart:convert';

import 'package:bgm/api/models/user_profile.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  static late SharedPreferences prefs;

  User user = User();

  static Future<SharedPreferences> initialize() async {
    return prefs = await SharedPreferences.getInstance();
  }

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

    prefs.setBool("userAttemptedConnection", true);

    var responseAPI = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(data),
    );

    if (responseAPI.statusCode == 200) {
      var data = json.decode(responseAPI.body);

      user = User.fromJson(data['user'], data['token']);

      setSession(user);

      result = true;
    } else {
      message = json.decode(responseAPI.body)["message"];
    }

    return <String, dynamic>{"result": result, "message": message};
  }

  String? getToken() {
    return prefs.getString("userToken");
  }

  setSession(User user) async {
    // prefs = await SharedPreferences.getInstance();

    prefs.setString('userId', user.id);
    prefs.setString('userPseudo', user.pseudo);
    prefs.setString('userToken', user.token);
  }

  static Map<String, String?> getUser() {
    return {
      "userId": prefs.getString('userId'),
      "userPseudo": prefs.getString("userPseudo")
    };
  }

  static Future setUserProfile(UserProfile userProfile) async {
    bool result = false, unauthorized = false;
    String message = '';

    Uri uri = Uri.parse(Constants.updateUserProfileURL);
    // final jsonUserProfile = jsonEncode(userProfile.toJson());
    var token = "Bearer ${prefs.getString('userToken')}";

    var responseAPI = await http.patch(
      uri,
      headers: {
        ...Constants.baseHeaders,
        "Authorization": token,
      },
      body: jsonEncode(userProfile.toJson()),
    );

    if (responseAPI.statusCode == 200 || responseAPI.statusCode == 201) {
      var data = json.decode(responseAPI.body);

      await prefs.setString('userProfile',
          jsonEncode(UserProfile.fromJson(data['data']).toJson()));

      result = true;
      message = data['message'];
    } else if (responseAPI.statusCode == 401) {
      unauthorized = true;
    } else {
      message = json.decode(responseAPI.body)["message"];
    }

    return <String, dynamic>{
      "result": result,
      "message": message,
      "unauthorized": unauthorized
    };
  }

  static UserProfile getUserProfile() {
    final json = prefs.getString('userProfile');
    return json == null
        ? UserProfile.empty()
        : UserProfile.fromJson(jsonDecode(json));
  }

  static Future<String> getUserStatus() async {
    if (prefs.getBool("userAttemptedConnection") == null) {
      //premi??re ouverture de l'app
      prefs.setBool("userAttemptedConnection", false);
      return 'intro';
    } else {
      if (!prefs.getBool("userAttemptedConnection")!) {
        //jamais essay?? de s'authentifier
        return 'intro';
      } else {
        // d??ja essay?? de s'authentifier
        if (prefs.getString("userToken") != null &&
            prefs.getString("userToken")!.isNotEmpty) {
          //effectivement authentifi??
          return 'home';
        }
        // d??j?? essay?? de s'authentifier mais non auth
        return "login";
      }
    }
  }

  static Future<void> logout() async {
    await prefs.clear();
  }

  //fin : Make with love, by JonathanDieke
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
