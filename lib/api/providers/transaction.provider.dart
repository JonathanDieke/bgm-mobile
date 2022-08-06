import 'dart:convert';

import 'package:app_monitor/api/models/transaction.dart';
import 'package:app_monitor/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> transactionList = [];

  Future<void> getTransactionList() async {
    String url = Constants.RAPPORT_URL;
    String token = "Bearer ";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token += sharedPreferences.getString('userToken');

    var result = await http.get(
      Uri.parse(url),
      headers: {"Authorization": token},
    );

    var data = jsonDecode(result.body)["data"]; 
    data.forEach((json) {
      transactionList.add(Transaction.fromJson(json));
    });
  }

  Iterable<Transaction> operatorsFilter(String operatorCode) {
    Iterable<Transaction> p2Transactions = this.transactionList.where(
        (transaction) =>
            transaction.operateur.toLowerCase() == operatorCode.toLowerCase());

    return p2Transactions;
  }

  //
}
