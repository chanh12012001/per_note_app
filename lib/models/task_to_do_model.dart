class TaskToDoModel {
  String? name;
  String? dueDate;
  bool? isCompleted;
  String? id;
  String? categoryId;

  TaskToDoModel({
    this.name,
    this.dueDate,
    this.isCompleted,
    this.categoryId,
    this.id,
  });

  TaskToDoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dueDate = json['dueDate'];
    isCompleted = json['isCompleted'];
    categoryId = json['categoryid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['dueDate'] = dueDate;
    data['isCompleted'] = isCompleted;
    data['categoryid'] = categoryId;
    return data;
  }
}
