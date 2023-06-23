import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/models/task_to_do_model.dart';
import 'package:per_note/providers/category_provider.dart';
import 'package:per_note/providers/task_to_do_provider.dart';
import 'package:per_note/screens/widgets/loader.dart';
import 'package:per_note/screens/widgets/task_to_do/change_task.dart';
import 'package:per_note/screens/widgets/task_to_do/detail_to_do.dart';
import 'package:provider/provider.dart';

class TaskToDo extends StatelessWidget {
  final Category? category;
  final Future<String> Function() reload;
  const TaskToDo({Key? key, this.category, required this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    return GestureDetector(
      //khi nhấn lâu sẽ thay đổi và xóa
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return showDiaglogChangeAndDelete(
                categoryProvider, category, context);
          },
        );
      },
      //khi nhấn 1 lần sẽ load dữ liệu
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailToDo(category: category);
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(int.parse(category!.color!, radix: 16)).withOpacity(0.8),
                Color(int.parse(category!.color!, radix: 16)).withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //chuyển đổi icon để thể hiện ra ngoài
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(
                IconData(int.parse(category!.icon!),
                    fontFamily: 'MaterialIcons'),
                color: Colors.black,
                size: 25,
              ),
            ),

            Text(
              category!.name!,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),

            // Hiển thị số task
            const Text(
              "4 Tasks",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatus(Color btnColor, Color txtColor, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: btnColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: TextStyle(color: txtColor),
      ),
    );
  }

  Widget showDiaglogChangeAndDelete(CategoryProvider categoryProvider,
      Category? category, BuildContext context) {
    return AlertDialog(
      title: Text("Lựa chọn"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ChangeTaskDialog(
                    oldColor: category!.color,
                    oldIcon: category.icon,
                    name: category.name,
                    reload: reload,
                    category: category,
                  );
                },
              );
              // Navigator.of(context).pop();
            },
            child: Text("Chỉnh sửa")),
        ElevatedButton(
            onPressed: () {
              categoryProvider.deleteCategory(category!);
              Navigator.of(context).pop();
              reload();
            },
            child: Text("Xóa")),
      ],
    );
  }
}
