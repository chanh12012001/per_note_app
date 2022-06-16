import 'package:flutter/material.dart';
import 'package:per_note/models/detail_healthy_index_model.dart';
import 'package:per_note/repositories/detail_healthy_index_repository.dart';

class DetailHealthyIndexProvider extends ChangeNotifier {
  DetailHealthyIndexRepository detailHealthyIndexRepository =
      DetailHealthyIndexRepository();
  static List<DetailHealthyIndex> detailHealthyIndexList = [];

  // get all
  Future<List<DetailHealthyIndex>> getAllDetailHealthyIndexByUserId(
      healthyIndexId) async {
    detailHealthyIndexList = await detailHealthyIndexRepository
        .getAllDetailHealthyIndexByUserId(healthyIndexId);
    return detailHealthyIndexList;
  }

  Future<DetailHealthyIndex> getDetailHealthyIndexLastest(
      healthyIndexId) async {
    DetailHealthyIndex newDetailHealthyIndex =
        await detailHealthyIndexRepository
            .getDetailHealthyIndexLastest(healthyIndexId);
    notifyListeners();
    return newDetailHealthyIndex;
  }

  Future<DetailHealthyIndex> createNewDetailHealthyIndex(
      date, time, value, healthyIndexId) async {
    DetailHealthyIndex newDetailHealthyIndex =
        await detailHealthyIndexRepository.createNewDetailHealthyIndex(
            date, time, value, healthyIndexId);
    detailHealthyIndexList.add(newDetailHealthyIndex);
    notifyListeners();
    return newDetailHealthyIndex;
  }

  Future<Map<String, dynamic>> deleteDetailHealthyIndex(
      DetailHealthyIndex detailHealthyIndex) async {
    Map<String, dynamic> result;
    result = await detailHealthyIndexRepository
        .deleteDetailHealthyIndex(detailHealthyIndex);
    detailHealthyIndexList.remove(detailHealthyIndex);
    notifyListeners();
    return result;
  }
}
