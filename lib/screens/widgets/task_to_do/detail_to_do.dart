import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/models/task_to_do_model.dart';
import 'package:per_note/providers/task_to_do_provider.dart';
import 'package:per_note/screens/widgets/loader.dart';
import 'package:provider/provider.dart';

class DetailToDo extends StatefulWidget {
  final Category? category;
  const DetailToDo({Key? key, this.category}) : super(key: key);

  @override
  State<DetailToDo> createState() => _DetailToDoState();
}

class _DetailToDoState extends State<DetailToDo> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime maxDate = now.add(Duration(days: 7));

    int differenceInDays = maxDate.difference(now).inDays;
    int addedDays = differenceInDays < 1 ? 0 : differenceInDays;

    DateTime formattedDateTime = now.add(Duration(days: 0));
    String formattedDate = DateFormat('dd/MM/yyyy').format(formattedDateTime);
    TaskToDoProvider taskToDoProvider =
        Provider.of<TaskToDoProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Danh sách công việc'),
        ),
        body: FutureBuilder<List<TaskToDoModel>>(
          future: taskToDoProvider.getAllTasksByCategoryId(
              widget.category!.id, formattedDate),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.hasError}");
            }
            return snapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, taskIndex) {
                      final task = snapshot.data![taskIndex];
                      return ListTile(
                        title: Text(task.name!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Hiển thị ngày làm việc khi lưu
                            // Text('${calculateDailyProgress}%'),
                            Text('Ngày cần làm: ${task.dueDate.toString()}'),
                            Row(
                              children: [
                                Checkbox(
                                  value: task.isCompleted,
                                  onChanged: (value) {
                                    // Đánh dấu công việc đã hoàn thành
                                    task.isCompleted = value ?? false;
                                    setState(() {});
                                  },
                                ),
                                Text('Đã hoàn thành'),
                              ],
                            ),
                          ],
                        ),
                      );
                    })
                : const Center(
                    child: ColorLoader(),
                  );
          },
        ));
  }
}
