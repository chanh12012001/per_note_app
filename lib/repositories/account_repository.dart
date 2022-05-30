import 'dart:convert';
import 'package:http/http.dart';
import 'package:per_note/models/account_model.dart';
import '../config/app_url_config.dart';
import '../preferences/user_preference.dart';

class AccountRepository {
  // get userId
  String? userId;
  Future<String> getUserId() => UserPreferences().getUserId();

  Future<Account> createNewAccount(title, username, password, note) async {
    await getUserId().then((value) => userId = value);

    final Map<String, dynamic> accountData = {
      'title': title,
      'username': username,
      'password': password,
      'note': note,
      'userId': userId,
    };

    Response response = await post(
      Uri.parse(AppUrl.createNewAccount),
      body: json.encode(accountData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = await json.decode(response.body)['account'];
      return Account.fromJson(responseBody);
    } else {
      throw Exception('Failed to add account');
    }
  }

  Future<List<Account>> getAccountsList() async {
    await getUserId().then((value) => userId = value);

    Response response = await get(
      Uri.parse(AppUrl.getAllAccounts),
      headers: {
        'Content-Type': 'application/json',
        'userid': userId!,
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['accounts'];
      return jsonResponse.map((account) => Account.fromJson(account)).toList();
    } else {
      throw Exception('Failed to load accounts from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteAccount(Account account) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteAccount + account.id!),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'],
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> updateAccount(
      id, title, username, password, note) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> accountData = {
      'title': title,
      'username': username,
      'password': password,
      'note': note,
    };
    Response response = await put(
      Uri.parse(AppUrl.updateAccount + id),
      body: json.encode(accountData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'],
      };
    }

    return result;
  }
}
