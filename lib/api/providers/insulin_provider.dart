import 'dart:convert';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';

class InsulinProvider extends ChangeNotifier{
   static late SharedPreferences prefs;

  static Future<SharedPreferences> initialize() async {
    return prefs = await SharedPreferences.getInstance();
  }

  Future<Map<String, dynamic>> saveInsulin(Map<String, dynamic> data) async {
    Uri uri = Uri.parse(Constants.createInsulinURL);
    var userToken = prefs.getString("userToken");
    // data['daily_data_id'] = prefs.getString("dailyDataId") ?? "";

    var responseAPI = await http.post(
      uri,
      headers: {
        ...Constants.baseHeaders,
        "Authorization": "Bearer $userToken",
      },
      body: jsonEncode(data),
    );

    Map<String, dynamic> result = processSwitchResponse(responseAPI);

    notifyListeners();

    return result;
  }

  Map<String, dynamic> processSwitchResponse(responseAPI) {
    bool result = false, unauthorized = false;
    String message = '';

    if (responseAPI.statusCode == 201 || responseAPI.statusCode == 200) {
      var data = json.decode(responseAPI.body); 

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
}