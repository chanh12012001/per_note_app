import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:per_note/config/theme.dart';

import '../../../models/task_model.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title ?? "",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.access_time_filled,
                        color: Color.fromARGB(255, 175, 70, 231),
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${widget.task.startTime} - ${widget.task.endTime}",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.green),
                        child: Text(
                          "Done",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getColor(int color) {
    switch (color) {
      case 0:
        return kPrimaryColor;
      case 1:
        return Colors.yellow[800];
      case 2:
        return Colors.pink[400];
      case 3:
        return Colors.teal[300];
      default:
        return kPrimaryColor;
    }
  }
}
