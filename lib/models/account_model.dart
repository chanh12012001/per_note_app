class Account {
  String? title;
  String? username;
  String? password;
  String? note;
  String? userId;
  String? id;

  Account(
      {this.title,
      this.username,
      this.password,
      this.note,
      this.userId,
      this.id});

  Account.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    username = json['username'];
    password = json['password'];
    note = json['note'];
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['username'] = username;
    data['password'] = password;
    data['note'] = note;
    data['userId'] = userId;
    data['id'] = id;
    return data;
  }
}
