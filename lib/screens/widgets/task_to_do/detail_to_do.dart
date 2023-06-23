import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/models/task_model.dart';
import 'package:per_note/models/task_to_do_model.dart';
import 'package:per_note/providers/task_provider.dart';
import 'package:per_note/screens/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    DateTime formattedDateTime = now.add(Duration(days: 0));
    String formattedDate = DateFormat('dd/MM/yyyy').format(formattedDateTime);
    TaskProvider taskToDoProvider =
        Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          _showStatics(Color(int.parse(widget.category!.color!, radix: 16)),
              taskToDoProvider, formattedDate),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: FutureBuilder<List<Task>>(
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
                            title: Text(task.title!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Hiển thị ngày làm việc khi lưu
                                // Text('${calculateDailyProgress}%'),
                                Text('Ngày cần làm: ${task.date.toString()}'),
                                Row(
                                  children: [
                                    Checkbox(
                                      value:
                                          task.isCompleted == 0 ? false : true,
                                      onChanged: (value) {
                                        // Đánh dấu công việc đã hoàn thành
                                        task.isCompleted =
                                            value == false ? 0 : 1;
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
            ),
          ),
        ],
      ),
    ));
  }

  _showStatics(
      Color color, TaskProvider taskToDoProvider, String formattedDate) {
    int count = 0;
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Task>>(
      future: taskToDoProvider.getAllTasksByCategoryId(
          widget.category!.id, formattedDate),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.hasError}");
        } else if (snapshot.hasData) {
          count = 0;
          for (int i = 0; i < snapshot.data!.length; i++) {
            if (snapshot.data![i].isCompleted == 1) {
              count++;
            }
          }
          return Container(
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              gradient: LinearGradient(colors: [
                Color(int.parse(widget.category!.color!, radix: 16))
                    .withOpacity(0.5),
                Color(int.parse(widget.category!.color!, radix: 16))
                    .withOpacity(0.9)
              ]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.category!.name}',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Kế hoạch của bạn",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Text(
                            "Đã hoàn thành ${count} / ${snapshot.data!.length}",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      // SfCircularChart(
                      //   series: <CircularSeries>[
                      //   PieSeries<Task, String>(
                      //     dataSource: <Task>[],
                      //   ),
                      // ]),
                    ],
                  ),
                )
              ]),
            ),
          );
        } else {
          return const Center(
            child: ColorLoader(),
          );
        }
      },
    );
  }
}
