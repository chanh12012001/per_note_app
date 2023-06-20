import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:per_note/screens/widgets/task_to_do/add_task_dialog.dart';

class AddNewTask extends StatelessWidget {
  final Future<String> Function() reload;
  const AddNewTask({Key? key, required this.reload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showDialog(
                context: context,
                builder: (BuildContext context) {
                  return  AddTaskDialog(reload: reload,);
                },
              );
      },
      //Nút thêm loại công việc
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        dashPattern: const [
          10,10
        ],
        color: Colors.grey,
        strokeWidth: 2,
        child: const Center(
          child: Text("+ Add",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          ),
        ),
        ),
    );
  }


}