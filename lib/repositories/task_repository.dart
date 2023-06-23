import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:per_note/config/app_url_config.dart';
import 'package:per_note/models/task_model.dart';
import 'package:per_note/models/task_to_do_model.dart';

class TaskRepository{
    Future<List<Task>> getAllTasksByCategoryId(
      taskcategoryid, date) async {
    Response response = await get(
      Uri.parse(AppUrl.getAllTasksByCategoryId),
      headers: {
        'Content-Type': 'application/json',
        'taskcategoryid': taskcategoryid!,
        'date': date
      },
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      List jsonResponse = json.decode(response.body)['task'];
      return jsonResponse.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load task from the Internet');
    }
  }
}