import 'dart:io';

import 'package:flutter/material.dart';
import 'package:per_note/models/healthy_index_model.dart';
import 'package:per_note/repositories/healthy_index_repository.dart';

class HealthyIndexProvider extends ChangeNotifier {
  HealthyIndexRepository healthyIndexRepository = HealthyIndexRepository();
  static List<HealthyIndex> healthyIndexs = [];

  // get all healthy indexs
  Future<List<HealthyIndex>> getHealthyIndexList() async {
    healthyIndexs = await healthyIndexRepository.getHealthyIndexList();
    return healthyIndexs;
  }

  Future<HealthyIndex> createNewHealthyIndex(
      String name, String unit, File? imageFile) async {
    HealthyIndex healthyIndex = await healthyIndexRepository
        .createNewHealthyIndex(name, unit, imageFile);
    healthyIndexs.add(healthyIndex);
    notifyListeners();
    return healthyIndex;
  }

  Future<File> convertUrlImageToFile(String imageUrl) async {
    File file = await healthyIndexRepository.urlToFile(imageUrl);
    notifyListeners();
    return file;
  }
}
