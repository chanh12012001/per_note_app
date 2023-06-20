import 'package:per_note/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:per_note/repositories/category_repository.dart';


class CategoryProvider extends ChangeNotifier {
  CategoryRepository categoryRepository = CategoryRepository();
  static List<Category> categories = [];

  // get all album
  Future<List<Category>> getCategoriesList() async {
    categories = await categoryRepository.getCategoriesList();
    return categories;
  }

  Future<Category> createNewCategory(String nameCategory, String color, String icon) async {
    Category newCategory = await categoryRepository.createNewCategory(nameCategory,color,icon);
    categories.add(newCategory);
    notifyListeners();
    return newCategory;
  }

  Future<Map<String, dynamic>> deleteCategory(Category category) async {
    Map<String, dynamic> result;
    result = await categoryRepository.deleteCategory(category);
    categories.remove(category);
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateCategory(String nameCategory, String color, String icon,Category category) async {
    Map<String, dynamic> result;
    result = await categoryRepository.updateCategory(nameCategory,color,icon,category);
    notifyListeners();
    return result;
  }
}