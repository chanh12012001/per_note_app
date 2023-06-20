import 'package:per_note/models/user_model.dart';

class Category {
  String? id;
  String? name;
  String? color;
  String? icon;
  String? userid;

  Category({this.id,this.name, this.color, this.icon, this.userid});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      color: json['color'],
      icon: json['icon'],
      userid: json['userId'],
    );
  }
}
