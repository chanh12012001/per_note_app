import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/providers/task_to_do_provider.dart';
import 'package:provider/provider.dart';

class AddTaskButton extends StatefulWidget {
  final List<Category> categories;
  final Future<String> Function() reload;
  const AddTaskButton(
      {Key? key, required this.categories, required this.reload})
      : super(key: key);
  @override
  _AddTaskButtonState createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedGroup = '';
  List categoriesList = [];
  List categoriesIdList = [];
  //hiển thị lịch để chọn ngày
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  //chọn loại công việc
  void _selectGroup(String? group) {
     _selectedGroup = group ?? '';
    setState(() {
     
    });
  }
  //định dạng ngày tháng năm
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }
  //hiển thị tab thêm việc cần làm
  void _showAddTaskDialog(
      BuildContext context, TaskToDoProvider taskToDoProvider) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Thêm công việc'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //điền tên
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Tên công việc'),
                    ),
                    SizedBox(height: 10),
                    //chọn ngày
                    Row(
                      children: <Widget>[
                        Text('Ngày tháng năm:'),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            _selectDate(context);
                            setState(() {});
                          },
                          child: Text(
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Loại:'),
                    SizedBox(height: 5),
                    //chọn nhóm
                    Container(
                      margin: EdgeInsets.all(8),
                      width: 100,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedGroup.isEmpty ? null : _selectedGroup,
                        onChanged: (String? value) {
                          _selectGroup(value);
                        },
                        items: categoriesList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Hủy'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Thêm'),
                  onPressed: () {
                    // Thực hiện thêm công việc vào danh sách công việc
                    //  lưu các giá trị đã chọn vào cơ sở dữ liệu hoặc thực hiện các xử lý khác.
                    String taskName = _nameController.text;
                    String selectedDate = formatDate(_selectedDate);
                    String selectedGroup = _selectedGroup;
                    //chuyển từ tên thành id để lưa chọn
                    for (int i = 0; i < widget.categories.length; i++) {
                      if (categoriesList[i] == _selectedGroup) {
                        selectedGroup = categoriesIdList[i];
                        break;
                      }
                    }
                    // Thực hiện thêm công việc
                    // ...
                    taskToDoProvider.uploadTasksToCategory(
                        selectedGroup, taskName, selectedDate, false);
                    // Đóng hộp thoại
                    Navigator.of(context).pop();
                    widget.reload();
                    setState(() {});
                  },
                ),
              ]);
        });
  }
  //danh sách id và tên
  void makeList() {
    for (int i = 0; i < widget.categories.length; i++) {
      if (categoriesList.length < widget.categories.length) {
        categoriesList.add(widget.categories[i].name);
        categoriesIdList.add(widget.categories[i].id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TaskToDoProvider taskToDoProvider =
        Provider.of<TaskToDoProvider>(context, listen: false);
    makeList();
    return Container(
      height: 50,
      width: 150,
      child: ElevatedButton(
          onPressed: () {
            _nameController.text = "";
            _selectedDate = DateTime.now();
            _selectedGroup = '';
            _showAddTaskDialog(context, taskToDoProvider);
            setState(() {});
          },
          child: Text("Thêm công việc")),
    );
  }
}
