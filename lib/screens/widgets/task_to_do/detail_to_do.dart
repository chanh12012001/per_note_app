import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/models/task_model.dart';
import 'package:per_note/providers/task_provider.dart';
import 'package:per_note/screens/widgets/loader.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:per_note/screens/widgets/schedule_manage/task_card.dart';
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, taskIndex) {
                          final task = snapshot.data![taskIndex];
                          return TaskCard(task: task);
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
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(colors: [
                Color(int.parse(widget.category!.color!, radix: 16))
                    .withOpacity(0.5),
                Color(int.parse(widget.category!.color!, radix: 16))
                    .withOpacity(0.9)
              ]),
            ),
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    CircularPercentIndicator(
                      radius: 50,
                      lineWidth: 10,
                      percent: count / snapshot.data!.length,
                      progressColor: Colors.black,
                      backgroundColor: Colors.white,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        "${(snapshot.data!.isNotEmpty ? (count * 100 / snapshot.data!.length).toStringAsFixed(1) : 0)}%",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )
            ]),
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
