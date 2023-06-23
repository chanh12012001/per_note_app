import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/models/task_model.dart';
import 'package:per_note/providers/category_provider.dart';
import 'package:per_note/providers/task_provider.dart';
import 'package:per_note/screens/widgets/input_field.dart';
import 'package:per_note/services/toast_service.dart';
import 'package:provider/provider.dart';
import '../../../services/notification_service.dart';
import '../widgets.dart';

class AddTaskScreen extends StatefulWidget {
  static const String routeName = '/add-task';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const AddTaskScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  NotificationService notifyService = NotificationService();
  ToastService toast = ToastService();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _remindController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = '11:59 PM';
  Category? _selectedTaskcategory;

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thêm công việc',
                style: headingStyle,
              ),
              InputField(
                controller: _titleController,
                title: 'Tiêu đề',
                hint: 'Nhập tiêu đề',
              ),
              InputField(
                controller: _noteController,
                title: 'Ghi chú',
                hint: 'Nhập ghi chú',
              ),
              InputField(
                title: 'Ngày',
                hint: DateFormat('dd/MM/yyyy').format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Thời gian bắt đầu',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: 'Thời gian kết thúc',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                          debugPrint(_endTime);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              InputField(
                controller: _remindController,
                title: 'Nhắc nhở',
                hint: 'Nhắc nhở trước ... phút. Ví dụ: 5, 10, 15,...',
                inputType: TextInputType.number,
              ),
              FutureBuilder<List<Category>>(
                future: categoryProvider.getCategoriesList(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.hasError}");
                  }
                  return snapshot.hasData
                      ? InputField(
                          title: 'Loại công việc',
                          hint: _selectedTaskcategory == null
                              ? "Chọn loại công việc"
                              : _selectedTaskcategory!.name!,
                          widget: DropdownButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                              ),
                              iconSize: 32,
                              elevation: 4,
                              style: subTitleStyle,
                              underline: Container(height: 0),
                              onChanged: (Category? value) {
                                setState(() {
                                  _selectedTaskcategory = value!;
                                });
                              },
                              items: snapshot.data!
                                  .map<DropdownMenuItem<Category>>(
                                      (Category? category) {
                                return DropdownMenuItem<Category>(
                                  value: category,
                                  child: Text(
                                    category!.name!,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                );
                              }).toList()),
                        )
                      : InputField(
                          title: 'Loại công việc',
                          hint: "Chọn loại công việc",
                          widget: DropdownButton<String>(
                            items: [],
                            onChanged: (String? value) {},
                          ),
                        );
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // _colorPallete(),
                  taskProvider.processedStatus == Status.processing
                      ? const ColorLoader()
                      : RoundedButton(
                          color: Colors.indigo[700],
                          text: 'THÊM',
                          onPressed: () async {
                            Task task = Task(
                              title: _titleController.text,
                              note: _noteController.text,
                              date: DateFormat('dd/MM/yyyy')
                                  .format(_selectedDate),
                              startTime: _startTime,
                              endTime: _endTime,
                              remind: int.tryParse(_remindController.text),
                              taskCategoryId: _selectedTaskcategory!.id,
                            );

                            await _addNewTask(task);
                          },
                          width: 0.9,
                        ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addNewTask(Task task) {
    if (task.title == '' || task.note == '' || task.remind == null) {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập đầy đủ thông tin',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
    } else {
      TaskProvider taskProvider =
          Provider.of<TaskProvider>(context, listen: false);

      taskProvider.createNewTask(task).then((response) {
        taskProvider.setprocessedStatus(Status.notProcess);
        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thao tác thành công',
          icon: Icons.check,
          backgroundColor: Colors.green,
        );
        DateTime date = DateFormat.jm().parse(response.startTime.toString());
        var myTime = DateFormat("HH:mm").format(date);
        notifyService.scheduledNotification(
            int.parse(myTime.toString().split(":")[0]),
            int.parse(myTime.toString().split(":")[1]),
            response);

        // else {
        //   toast.showToast(
        //     context: context,
        //     message: 'Lỗi! Vui lòng thử lại.',
        //     icon: Icons.error,
        //     backgroundColor: Colors.redAccent,
        //   );
        // }
      });
    }
  }

  // _colorPallete() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Màu sắc',
  //         style: titleStyle,
  //       ),
  //       const SizedBox(
  //         height: 8,
  //       ),
  //       Wrap(
  //         children: List<Widget>.generate(
  //           4,
  //           (index) {
  //             return GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   _selectedColor = index;
  //                 });
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.only(right: 8.0),
  //                 child: CircleAvatar(
  //                   radius: 14,
  //                   backgroundColor: index == 0
  //                       ? kPrimaryColor
  //                       : index == 1
  //                           ? Colors.yellow[600]
  //                           : index == 2
  //                               ? Colors.pink[400]
  //                               : Colors.teal[300],
  //                   child: _selectedColor == index
  //                       ? const Icon(
  //                           Icons.done,
  //                           color: Colors.white,
  //                           size: 16,
  //                         )
  //                       : Container(),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime(2122),
    );
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {}
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      debugPrint('Time cancel');
    } else {
      DateTime tempDate =
          DateFormat("hh:mm").parse("${pickedTime.hour}:${pickedTime.minute}");
      var dateFormat = DateFormat("h:mm a"); // you can change the format here
      String formatedDate = dateFormat.format(tempDate);
      if (isStartTime) {
        setState(() {
          _startTime = formatedDate;
        });
      } else if (!isStartTime) {
        setState(() {
          _endTime = formatedDate;
        });
      }
    }
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      builder: (context, childWidget) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: childWidget!);
      },
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
