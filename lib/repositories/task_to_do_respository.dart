import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:per_note/models/image_model.dart';
import 'package:per_note/models/task_to_do_model.dart';
import '../config/app_url_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class TaskToDoRepository {
  Future uploadTasksToCategory(categoryId, name, dueDate, isCompleted) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> taskData = {
      'name': name,
      'dueDate': dueDate,
      'isCompleted': isCompleted,
      'categoryid': categoryId,
    };
    Response response = await post(
      Uri.parse(AppUrl.uploadTasksToCategory),
      body: json.encode(taskData),
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

  Future<List<TaskToDoModel>> getAllTasksByCategoryId(
      categoryId, dueDate) async {
    Response response = await get(
      Uri.parse(AppUrl.getAllTasksByCategoryId),
      headers: {
        'Content-Type': 'application/json',
        'categoryid': categoryId!,
        'dueDate': dueDate
      },
    );
    debugPrint(dueDate);
    if (response.statusCode == 200) {
      debugPrint(response.body);
      List jsonResponse = json.decode(response.body)['task'];
      return jsonResponse.map((task) => TaskToDoModel.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load task from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteTasksOfCategory(String taskIds) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteTasksOfCategory + taskIds),
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
        'message': 'Xoá thất bại',
      };
    }

    return result;
  }
}
