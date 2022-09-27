import 'dart:convert';

import 'package:bgm/api/models/daily_data.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class DailyDataProvider with ChangeNotifier {
  static DailyData dailyData = DailyData();
  static late SharedPreferences prefs;

  static Future<SharedPreferences> initialize() async {
    return prefs = await SharedPreferences.getInstance();
  }

  Future<Map<String, dynamic>> saveDailyData(
      int nbHyperglycemia, int nbHypoglycemia, int isSick) async {
    // prefs = await SharedPreferences.getInstance();
    var token = "Bearer ${prefs.getString('userToken')}";
    // final String? dailyDataId = isForCurrentDay() ? prefs.getString("dailyDataId") : "";
    Uri uri = Uri.parse(Constants.createDailyData);

    Map<String, dynamic> data = {
      'nb_hyperglycemia': nbHyperglycemia,
      'nb_hypoglycemia': nbHypoglycemia,
      "is_sick": isSick,
      // "id": dailyDataId,
    };

    var responseAPI = await http.post(
      uri,
      headers: {
        ...Constants.baseHeaders,
        "Authorization": token,
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

      dailyData = DailyData.fromJson(data['data']);

      setDailyData(dailyData);

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

  Future<void> setDailyData(DailyData dailyData) async {
    /** 
     * Verifier si les data sont les premiers de la journées : 
     * autrement dit verifier s'il s'agit d'un "create" ou un "update"
     * On entre dans la condition seulement en cas de create
     * 
     * On enregistre donc le nouvelle Id généré par le backend et l'attribut createdAt
    */
    // if (!isForCurrentDay()) {
    //   prefs.setString('dailyDataId', dailyData.id);
    //   prefs.setString("dailyDataCreatedAt", dailyData.createdAt.toString());
    // }
    prefs.setString('dailyDataId', dailyData.id);
    prefs.setString("dailyDataCreatedAt", dailyData.createdAt.toString());

    prefs.setInt('dailyDataNbHyperglycemia', dailyData.nbHyperglycemia);
    prefs.setInt('dailyDataNbHypoglycemia', dailyData.nbHypoglycemia);
    prefs.setInt('dailyDataIsSick', dailyData.isSick);
    prefs.setString("dailyDataUpdatedAt", dailyData.updatedAt.toString());
  }

  static Future<DailyData> getDailyData() async {
    // prefs = await SharedPreferences.getInstance();
    dailyData = DailyData.fromStorage(
      prefs.getString("dailyDataId") ?? "",
      prefs.getInt("dailyDataNbHyperglycemia") ?? 0,
      prefs.getInt("dailyDataNbHypoglycemia") ?? 0,
      prefs.getInt("dailyDataIsSick") ?? 0,
      prefs.getString("dailyDataCreatedAt") ?? "",
      prefs.getString("dailyDataUpdatedAt") ?? "",
    );

    if (!dailyData.isForCurrentDay()) {
      dailyData = DailyData();
    }

    return dailyData;
    // notifyListeners();
  }

  bool isForCurrentDay() {
    final String? previousDailyDataDate =
        prefs.getString("dailyDataCreatedAt")?.split('T')[0];
    final String currentDate = DateTime.now().toString().split(" ")[0];

    bool isForCurrentDay =
        previousDailyDataDate is String && previousDailyDataDate == currentDate;

    if (!isForCurrentDay) {
      clearDailyDataCache();
    }

    return isForCurrentDay;
  }

  void clearDailyDataCache() {
    prefs.remove("dailyDataId");
    prefs.remove("dailyDataNbHyperglycemia");
    prefs.remove("dailyDataNbHypoglycemia");
    prefs.remove("dailyDataIsSick");
    prefs.remove("dailyDataCreatedAt");
    prefs.remove("dailyDataUpdatedAt");

    notifyListeners();
  }

  void clearSP() async {
    // prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  //
}
