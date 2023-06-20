import 'dart:io';
import 'package:flutter/material.dart';
import 'package:per_note/models/task_to_do_model.dart';
import 'package:per_note/repositories/task_to_do_respository.dart';


class TaskToDoProvider extends ChangeNotifier {
  TaskToDoRepository taskToDoRepository = TaskToDoRepository();
  static List<TaskToDoModel> todos = [];

  Future<List<TaskToDoModel>> getAllTasksByCategoryId(categoryId,dueDate) async {
    todos = await taskToDoRepository.getAllTasksByCategoryId(categoryId,dueDate);
    // notifyListeners();
    return todos;
  }

  Future uploadTasksToCategory(categoryId,name,dueDate,isCompleted) async {
    await taskToDoRepository.uploadTasksToCategory(categoryId, name,dueDate,isCompleted);
    notifyListeners();
  }

  Future<Map<String, dynamic>> deleteTasksOfCategory(String taskIds) async {
    Map<String, dynamic> result;
    debugPrint(taskIds);
    result = await taskToDoRepository.deleteTasksOfCategory(taskIds);
    //albums.remove(album);
    notifyListeners();
    return result;
  }
}
