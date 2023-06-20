import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:per_note/models/album_model.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/models/first_image_album_slider_model.dart';
import '../config/app_url_config.dart';
import '../preferences/user_preference.dart';

class CategoryRepository {
  // get userId
  String? userId;
  Future<String> getUserId() => UserPreferences().getUserId();

  Future<Category> createNewCategory(String nameCategory, String color, String icon) async {
    await getUserId().then((value) => userId = value);

    final Map<String, dynamic> categoryData = {
      'name': nameCategory,
      'color': color,
      'icon': icon,
      'userId': userId,
    };

    Response response = await post(
      Uri.parse(AppUrl.createNewCategory),
      body: json.encode(categoryData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = await json.decode(response.body)['category'];
      return Category.fromJson(responseBody);
    } else {
      throw Exception('Failed to add category');
    }
  }

  Future<List<Category>> getCategoriesList() async {
    await getUserId().then((value) => userId = value);

    Response response = await get(
      Uri.parse(AppUrl.getAllCategories),
      headers: {
        'Content-Type': 'application/json',
        'userid': userId!,
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['categories'];
      return jsonResponse
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load category from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteCategory(Category category) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteCategory + category.id!),
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

  Future<Map<String, dynamic>> updateCategory(
      String nameCategory, String color, String icon,Category category) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> categoryData = {
            'name': nameCategory,
      'color': color,
      'icon': icon,
      'userId': userId,
    };
    Response response = await put(
      Uri.parse(AppUrl.updateCategory +category.id!),
      body: json.encode(categoryData),
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
