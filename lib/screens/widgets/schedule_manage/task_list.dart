import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:per_note/models/task_model.dart';
import 'package:per_note/providers/loading_provider.dart';
import 'package:per_note/providers/task_provider.dart';
import 'package:per_note/screens/widgets/schedule_manage/task_card.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:per_note/services/notification_service.dart';
import 'package:per_note/services/toast_service.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  final List<Task> tasks;
  final DateTime selectedDate;
  final Axis? scrollDirection;
  const TaskList({
    Key? key,
    required this.tasks,
    required this.selectedDate,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  ToastService toast = ToastService();
  NotificationService notifyService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Consumer<TaskProvider>(builder: (context, taskProvider, child) {
        var tasks = taskProvider.getTasks;
        return ListView.builder(
          scrollDirection: widget.scrollDirection!,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            Task task = tasks[index];

            if (task.date ==
                DateFormat('dd/MM/yyyy').format(widget.selectedDate)) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                      child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskCard(task: task),
                      ),
                    ],
                  )),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }

  _showBottomSheet(context, Task task) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.only(top: 6, left: 20, right: 20),
          height: task.isCompleted == 1
              ? MediaQuery.of(context).size.height * 0.24
              : MediaQuery.of(context).size.height * 0.365,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              task.isCompleted == 1
                  ? Container()
                  : RoundedButton(
                      text: 'Task Completed',
                      onPressed: () {
                        notifyService.cancelNotificationById(task.id!);
                        _updateTaskCompletion(task);
                      },
                      width: 1,
                      color: Colors.indigo[800],
                    ),
              RoundedButton(
                text: 'Delete Task',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return MyAlertDialog(
                        title: 'Warning !!!',
                        subTitle: 'Bạn có chắc chắn muốn xoá ?',
                        action: () {
                          notifyService.cancelNotificationById(task.id!);
                          _deleteTask(task);
                          setState(() {
                            loadingProvider.setLoading(false);
                          });
                        },
                      );
                    },
                  );
                },
                width: 1,
                color: Colors.red[300],
              ),
              RoundedButton(
                text: 'Close',
                onPressed: () {
                  Navigator.pop(context);
                },
                width: 1,
                color: Colors.grey[500],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }

  _deleteTask(Task task) {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);

    taskProvider.deleteTask(task).then((response) {
      if (response) {
        Navigator.pop(context);

        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thao tác thành công',
          icon: Icons.check,
          backgroundColor: Colors.green,
        );
      }
    });
  }

  _updateTaskCompletion(Task task) async {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);

    taskProvider.updateTaskCompletion(task).then((response) {
      if (response) {
        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thao tác thành công',
          icon: Icons.check,
          backgroundColor: Colors.green,
        );
      }
    });
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
