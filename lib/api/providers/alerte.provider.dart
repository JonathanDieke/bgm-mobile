import 'dart:async';
import 'dart:convert';

import 'package:app_monitor/api/models/alerte.dart';
import 'package:app_monitor/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AlerteProvider extends ChangeNotifier {
  List<Alerte> alerteList;

  AlerteProvider() {
    alerteList = [];
  }

  Future<void> getAlertList() async {
    print('get alerte list ');
    String url = Constants.ALERTE_URL;
    String token = "Bearer ";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token += sharedPreferences.getString('userToken');

    var result = await http.get(
      Uri.parse(url),
      headers: {"Authorization": token},
    );

    List<dynamic> data = jsonDecode(result.body)["data"];

    data.forEach((json) {
      alerteList.add(Alerte.fromJson(json));
    });

    notifyListeners();
  }

  // fluxAlerteList() {
  //   while (true) {
  //     this.getAlertList();

  //     Timer(Duration(minutes: 15), () {});
  //   }
  // }

  //
}
