import 'package:flutter/material.dart';
import 'package:per_note/models/account_model.dart';
import 'package:per_note/repositories/account_repository.dart';

class AccountProvider extends ChangeNotifier {
  AccountRepository accountRepository = AccountRepository();
  static List<Account> accounts = [];

  // get all album
  Future<List<Account>> getAccountsList() async {
    accounts = await accountRepository.getAccountsList();
    return accounts;
  }

  Future<Account> createNewAccount(title, username, password, note) async {
    Account newAccount = await accountRepository.createNewAccount(
        title, username, password, note);
    accounts.add(newAccount);
    notifyListeners();
    return newAccount;
  }

  Future<Map<String, dynamic>> deleteAccount(Account account) async {
    Map<String, dynamic> result;
    result = await accountRepository.deleteAccount(account);
    accounts.remove(account);
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateAlbum(
      id, title, username, password, note) async {
    Map<String, dynamic> result;
    result = await accountRepository.updateAccount(
        id, title, username, password, note);
    notifyListeners();
    return result;
  }
}
