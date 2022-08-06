import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../models/user.dart';

class MealProvider extends ChangeNotifier {
  User user = User();
  late SharedPreferences prefs;

  Future<void> addMeal(Map<String, dynamic> data) async {
    Uri uri = Uri.parse(Constants.addMealURL);
    bool result = false;
    String message = '';

    prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString("userToken");

    var responseAPI = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $userToken",
      },
      body: jsonEncode(data),
    );

    // print(responseAPI.statusCode);

    if (responseAPI.statusCode == 200) {
      var response = json.decode(responseAPI.body);

      // print("data : ${data.toString()}");

      result = true;
    } else {
      message = json.decode(responseAPI.body)["error"];
    }

    // return <String, dynamic>{"result": result, "message": message};
  }
}
