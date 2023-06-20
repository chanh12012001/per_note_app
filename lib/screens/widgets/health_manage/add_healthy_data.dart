import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/healthy_index_model.dart';
import 'package:per_note/providers/detail_healthy_index_provider.dart';
import 'package:per_note/screens/widgets/input_field.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:per_note/services/toast_service.dart';
import 'package:provider/provider.dart';

class AddHealthyData extends StatefulWidget {
  final HealthyIndex healthyIndex;
  const AddHealthyData({
    Key? key,
    required this.healthyIndex,
  }) : super(key: key);

  @override
  State<AddHealthyData> createState() => _AddHealthyDataState();
}

class _AddHealthyDataState extends State<AddHealthyData> {
  bool loading = false;
  ToastService toast = ToastService();
  DateTime _selectedDate = DateTime.now();
  String _time = DateFormat('HH:mm').format(DateTime.now()).toString();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _indexValueController = TextEditingController();
  final TextEditingController _indexSubValueController1 =
      TextEditingController();
  final TextEditingController _indexSubValueController2 =
      TextEditingController();

  Map<String, TextEditingController> controllers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Nhập chỉ số ${widget.healthyIndex.name}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InputField(
                controller: _dateController,
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
              InputField(
                controller: _timeController,
                title: 'Thời gian',
                hint: _time,
                widget: IconButton(
                  onPressed: () {
                    _getTimeFromUser();
                  },
                  icon: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
              _buildTextFieldByHealthyIndex(widget.healthyIndex.name),
              loading == true
                  ? const ColorLoader()
                  : RoundedButton(
                      text: "Gửi kết quả",
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        _addDetailHealthyIndex(
                          DateFormat('dd/MM/yyyy').format(_selectedDate),
                          _time,
                          _getIndexValueByHealthyIndex(
                              widget.healthyIndex.name),
                          widget.healthyIndex.id,
                        );
                      },
                      width: 1,
                    )
            ],
          ),
        ),
      ),
    );
  }

  _addDetailHealthyIndex(date, time, value, healthyIndexId) async {
    DetailHealthyIndexProvider detailHealthyIndexProvider =
        Provider.of<DetailHealthyIndexProvider>(context, listen: false);

    if (value == '') {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập đầy đủ thông tin',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
      setState(() {
        loading = false;
      });
    } else {
      detailHealthyIndexProvider
          .createNewDetailHealthyIndex(date, time, value, healthyIndexId)
          .then((value) {
        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thêm thành công',
          icon: Icons.error,
          backgroundColor: Colors.green,
        );
      });
      setState(() {
        loading = false;
      });
    }
  }

  _getIndexValueByHealthyIndex(healthyIndexName) {
    switch (healthyIndexName) {
      case "Huyết áp":
        return "${_indexSubValueController1.text}/${_indexSubValueController2.text}";
      case "BMI":
        double meters = (double.parse(_indexSubValueController1.text) / 100);
        double resultBMI =
            (double.parse(_indexSubValueController2.text) / (pow(meters, 2)));
        return resultBMI.toStringAsFixed(1);
      default:
        return _indexValueController.text;
    }
  }

  _buildTextFieldByHealthyIndex(healthyIndexName) {
    if (healthyIndexName == "Huyết áp" || healthyIndexName == "BMI") {
      return Column(
        children: [
          InputField(
            controller: _indexSubValueController1,
            title: healthyIndexName == "Huyết áp"
                ? "Tâm thu (Chỉ số trên)"
                : "Chiều cao (cm)",
            hint: "Nhập nội dung",
          ),
          InputField(
            controller: _indexSubValueController2,
            title: healthyIndexName == "Huyết áp"
                ? "Tâm trương (Chỉ số dưới)"
                : "Cân nặng (kg)",
            hint: "Nhập nội dung",
          ),
          const SizedBox(
            height: 10,
          )
        ],
      );
    }
    return InputField(
      controller: _indexValueController,
      title: "${widget.healthyIndex.name!} (${widget.healthyIndex.unit!})",
      hint: "Nhập nội dung",
    );
  }

  _getTimeFromUser() async {
    var pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      debugPrint('Time cancel');
    } else {
      DateTime tempDate = DateFormat("hh:mm").parse(
          "${pickedTime.hour}:${pickedTime.minute}");
      var dateFormat = DateFormat("HH:mm"); // you can change the format here
      String formatedDate = dateFormat.format(tempDate);

      setState(() {
        _time = formatedDate;
      });
    }
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      builder: (context, childWidget) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: childWidget!);
      },
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_time.split(":")[0]),
        minute: int.parse(_time.split(":")[1].split(" ")[0]),
      ),
    );
  }

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
}
