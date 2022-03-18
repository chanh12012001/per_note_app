import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:per_note/config/app_url_config.dart';
import 'package:per_note/models/spending_model.dart';
import 'package:per_note/preferences/user_preference.dart';

enum Status {
  notProcess,
  processing,
  processed,
}

class SpendingProvider extends ChangeNotifier {
  static List<Spending> spendings = [];
  Status _processedStatus = Status.notProcess;

  Status get processedStatus => _processedStatus;

  void setprocessedStatus(Status status) {
    _processedStatus = status;
    notifyListeners();
  }

  List<Spending> get getSpendings {
    return spendings;
  }

  // get userId
  String? userId;
  Future<String> getUserId() => UserPreferences().getUserId();

  //
  Future<Spending> createNewSpending(Spending spending) async {
    await getUserId().then((value) => userId = value);

    final Map<String, dynamic> spendingData = {
      'kind': spending.kind,
      'money': spending.money,
      'date': spending.date,
      'userId': userId,
    };

    _processedStatus = Status.processing;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.createNewSpending),
      body: json.encode(spendingData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _processedStatus = Status.processed;
      final responseBody = await json.decode(response.body)['spending'];
      Spending spending1 = Spending.fromJson(responseBody);
      spendings.add(spending1);
      notifyListeners();

      return spending1;
    } else {
      _processedStatus = Status.notProcess;
      notifyListeners();

      throw Exception(response.statusCode);
    }
  }

  Future<List<Spending>> getSpendingList() async {
    await getUserId().then((value) => userId = value);

    _processedStatus = Status.processing;
    notifyListeners();

    Response response = await get(
      Uri.parse(AppUrl.getAllSpendings),
      headers: {
        'Content-Type': 'application/json',
        'userid': userId!,
      },
    );

    if (response.statusCode == 200) {
      _processedStatus = Status.processed;
      notifyListeners();

      List jsonResponse = json.decode(response.body)['spendings'];
      spendings =
          jsonResponse.map((spending) => Spending.fromJson(spending)).toList();
      notifyListeners();
      return spendings;
    } else {
      _processedStatus = Status.notProcess;
      notifyListeners();

      throw Exception('Failed to load spending from the Internet');
    }
  }

}
