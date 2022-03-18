import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:per_note/models/spending_model.dart';
import 'package:per_note/providers/spending_provider.dart';
import 'package:per_note/screens/Financal_page/kind_spending.dart';
import 'package:per_note/services/notification_service.dart';
import 'package:per_note/services/toast_service.dart';
import 'package:provider/provider.dart';

class addSpending extends StatefulWidget {
  const addSpending({Key? key}) : super(key: key);

  @override
  State<addSpending> createState() => _addSpendingState();
}

class _addSpendingState extends State<addSpending> {
  NotificationService notifyService = NotificationService();
  ToastService toast = ToastService();
  final TextEditingController moneyController = TextEditingController();
  String _selectedkind = 'Khác';
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.save,
                    size: 30,
                  ),
                  onPressed: () async {
                    Spending spending = Spending(
                        kind: _selectedkind,
                        money: int.tryParse(moneyController.text),
                        date:
                            "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}");
                    await _addNewSpending(spending);
                    // total = total + double.tryParse(moneyController.text);
                    Navigator.of(context).pop();
                  },
                  label: Text(
                    'Lưu',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20),
                    ),
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    shadowColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              iconSize: 35,
              items: kinds.map(kindSpendingMenu).toList(),
              onChanged: (value) => setState(() {
                this.value = value;
                _selectedkind = value!;
              }),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            //Nhap vao so tien
            child: TextField(
              controller: moneyController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              keyboardType: TextInputType.number,
              cursorHeight: 20,
              decoration: new InputDecoration.collapsed(
                hintText: 'Nhập vào số tiền',
                hintStyle: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? value;
  DropdownMenuItem<String> kindSpendingMenu(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
  _addNewSpending(Spending spending) {
    if (spending.money == null) {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập đầy đủ thông tin',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
    } else {
      SpendingProvider spendingProvider =
          Provider.of<SpendingProvider>(context, listen: false);

      spendingProvider.createNewSpending(spending).then((response) {
        spendingProvider.setprocessedStatus(Status.notProcess);
        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thao tác thành công',
          icon: Icons.check,
          backgroundColor: Colors.green,
        );
      });
    }
  }
}
