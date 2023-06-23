class Task {
  String? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  String? taskCategoryId;
  String? userId;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.taskCategoryId,
    this.userId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      title: json['title'],
      note: json['note'],
      isCompleted: json['isCompleted'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      remind: json['remind'],
      taskCategoryId: json['taskCategoryId'],
      userId: json['userId'],
    );
  }
}
