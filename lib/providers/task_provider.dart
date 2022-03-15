import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:per_note/config/app_url_config.dart';
import 'package:per_note/models/task_model.dart';
import 'package:per_note/preferences/user_preference.dart';

enum Status {
  notProcess,
  processing,
  processed,
}

class TaskProvider extends ChangeNotifier {
  static List<Task> tasks = [];
  Status _processedStatus = Status.notProcess;

  Status get processedStatus => _processedStatus;

  void setprocessedStatus(Status status) {
    _processedStatus = status;
    notifyListeners();
  }

  List<Task> get getTasks {
    return tasks;
  }

  // get userId
  String? userId;
  Future<String> getUserId() => UserPreferences().getUserId();

  //
  Future<Task> createNewTask(Task task) async {
    await getUserId().then((value) => userId = value);

    final Map<String, dynamic> taskData = {
      'title': task.title,
      'note': task.note,
      'isCompleted': 0,
      'date': task.date,
      'startTime': task.startTime,
      'endTime': task.endTime,
      'color': task.color,
      'remind': task.remind,
      'repeat': task.repeat,
      'userId': userId,
    };

    _processedStatus = Status.processing;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.createNewTask),
      body: json.encode(taskData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _processedStatus = Status.processed;
      final responseBody = await json.decode(response.body)['task'];
      Task task1 = Task.fromJson(responseBody);
      tasks.add(task1);
      notifyListeners();

      return task1;
    } else {
      _processedStatus = Status.notProcess;
      notifyListeners();

      throw Exception('Failed to add task');
    }
  }

  Future<List<Task>> getTasksList() async {
    await getUserId().then((value) => userId = value);

    _processedStatus = Status.processing;
    notifyListeners();

    Response response = await get(
      Uri.parse(AppUrl.getAllTasks),
      headers: {
        'Content-Type': 'application/json',
        'userid': userId!,
      },
    );

    if (response.statusCode == 200) {
      _processedStatus = Status.processed;
      notifyListeners();

      List jsonResponse = json.decode(response.body)['tasks'];
      tasks = jsonResponse.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
      return tasks;
    } else {
      _processedStatus = Status.notProcess;
      notifyListeners();

      throw Exception('Failed to load task from the Internet');
    }
  }

  Future<bool> deleteTask(Task task) async {
    _processedStatus = Status.processing;
    notifyListeners();

    Response response = await delete(
      Uri.parse(AppUrl.deleteTask + task.id!),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _processedStatus = Status.processed;
      tasks.remove(task);
      notifyListeners();

      return true;
    } else {
      _processedStatus = Status.notProcess;
      notifyListeners();

      return false;
    }
  }

  Future<bool> updateTaskCompletion(Task task) async {
    _processedStatus = Status.processing;
    notifyListeners();

    Response response = await put(
      Uri.parse(AppUrl.updateTaskCompletion + task.id!),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _processedStatus = Status.processed;
      await getTasksList();
      notifyListeners();
      return true;
    } else {
      _processedStatus = Status.notProcess;
      notifyListeners();

      return false;
    }
  }
}
