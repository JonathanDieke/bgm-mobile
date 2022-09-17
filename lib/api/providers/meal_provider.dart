import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../models/meal.dart';

class MealProvider extends ChangeNotifier {
  Meal meal = Meal();
  static late SharedPreferences prefs;

  static Future<SharedPreferences> initialize() async {
    return prefs = await SharedPreferences.getInstance();
  }

  Future<Map<String, dynamic>> saveMeal(Map<String, dynamic> data) async {
    // clearMealCache();

    Uri uri = Uri.parse(Constants.createMealURL);
    var userToken = prefs.getString("userToken");
    data['id'] = isForCurrentDay(data) ? getIdSwitchMealType(data) : "";

    var responseAPI = await http.post(
      uri,
      headers: {
        ...Constants.baseHeaders,
        "Authorization": "Bearer $userToken",
      },
      body: jsonEncode(data),
    );

    
    print(responseAPI.statusCode);
    print(responseAPI.body);

    Map<String, dynamic> result = processSwitchResponse(responseAPI);

    notifyListeners();

    return result;
  }

  Map<String, dynamic> processSwitchResponse(responseAPI) {
    bool result = false, unauthorized = false;
    String message = '';

    if (responseAPI.statusCode == 201 || responseAPI.statusCode == 200) {
      var data = json.decode(responseAPI.body);

      meal = Meal.fromJson(data['data']);

      setMeal(meal);

      message = data['message'];
      result = true;
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

  Future<void> setMeal(Meal meal) async {
    if (meal.type == 'first_breakfast') {
      prefs.setString('mealIdFirstBreakfast', meal.id);
      prefs.setString("mealCreatedAtFirstBreakfast", meal.createdAt.toString());
    } else if (meal.type == 'breakfast') {
      prefs.setString('mealIdBreakfast', meal.id);
      prefs.setString("mealCreatedAtBreakfast", meal.createdAt.toString());
    } else if (meal.type == 'dinner') {
      prefs.setString('mealIdDinner', meal.id);
      prefs.setString("mealCreatedAtDinner", meal.createdAt.toString());
    }
  }

  bool isForCurrentDay(Map<String, dynamic> data) {
    String? previousMealDate = "";
    if (data["type"] == 'first_breakfast') {
      previousMealDate =
          prefs.getString("mealCreatedAtFirstBreakfast")?.split('T')[0];
    } else if (data["type"] == 'breakfast') {
      previousMealDate =
          prefs.getString("mealCreatedAtBreakfast")?.split('T')[0];
    } else if (data["type"] == 'dinner') {
      previousMealDate = prefs.getString("mealCreatedAtDinner")?.split('T')[0];
    }

    final String currentDate = DateTime.now().toString().split(" ")[0];
    bool isForCurrentDay =
        previousMealDate is String && previousMealDate == currentDate;

    // if (!isForCurrentDay) {
    //   clearMealCache();
    // }

    return isForCurrentDay;
  }

  void clearMealCache() {
    prefs.remove("mealIdFirstBreakfast");
    prefs.remove("mealIdBreakfast");
    prefs.remove("mealIdDinner");
    prefs.remove("mealCreatedAtFirstBreakfast");
    prefs.remove("mealCreatedAtBreakfast");
    prefs.remove("mealCreatedAtDinner");

    // notifyListeners();
  }

  getIdSwitchMealType(Map<String, dynamic> data) {
    if (data['type'] == 'first_breakfast') {
      return prefs.getString('mealIdFirstBreakfast');
    } else if (data['type'] == 'breakfast') {
      return prefs.getString('mealIdBreakfast');
    } else if (data['type'] == 'dinner') {
      return prefs.getString('mealIdDinner');
    }
  }
}
