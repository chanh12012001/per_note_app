import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/account_model.dart';
import 'package:per_note/providers/account_provider.dart';
import 'package:per_note/screens/widgets/input_field.dart';
import 'package:per_note/services/toast_service.dart';
import 'package:provider/provider.dart';

import '../../../../services/notification_service.dart';
import '../../rounded_button.dart';

class AddAndEditAccount extends StatefulWidget {
  final Account? account;
  const AddAndEditAccount({Key? key, this.account}) : super(key: key);

  @override
  State<AddAndEditAccount> createState() => _AddAndEditAccountScreenState();
}

class _AddAndEditAccountScreenState extends State<AddAndEditAccount> {
  NotificationService notifyService = NotificationService();
  ToastService toast = ToastService();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                widget.account != null
                    ? 'Cập nhật tài khoản'
                    : 'Thêm tài khoản',
                style: headingStyle,
              ),
              InputField(
                controller: widget.account != null
                    ? TextEditingController(text: widget.account!.title)
                    : _titleController,
                title: 'Tiêu đề',
                hint: 'Nhập tiêu đề',
                onChanged: (value) {
                  if (widget.account != null) {
                    widget.account!.title = value;
                  }
                },
              ),
              InputField(
                controller: widget.account != null
                    ? TextEditingController(text: widget.account!.username)
                    : _usernameController,
                title: 'Tên tài khoản',
                hint: 'Nhập tên tài khoản',
                onChanged: (value) {
                  if (widget.account != null) {
                    widget.account!.username = value;
                  }
                },
              ),
              InputField(
                controller: widget.account != null
                    ? TextEditingController(text: widget.account!.password)
                    : _passwordController,
                title: 'Mật khẩu',
                hint: 'Nhập mật khẩu',
                onChanged: (value) {
                  if (widget.account != null) {
                    widget.account!.password = value;
                  }
                },
              ),
              InputField(
                controller: widget.account != null
                    ? TextEditingController(text: widget.account!.note)
                    : _noteController,
                title: 'Ghi chú',
                hint: 'Nhập ghi chú (nếu có)',
                onChanged: (value) {
                  if (widget.account != null) {
                    widget.account!.note = value;
                  }
                },
              ),
              const SizedBox(
                height: 18,
              ),
              RoundedButton(
                color: Colors.indigo[700],
                text: widget.account != null ? 'Lưu' : 'Thêm',
                onPressed: () {
                  widget.account != null
                      ? _updateAccount(
                          widget.account!.id,
                          widget.account!.title,
                          widget.account!.username,
                          widget.account!.password,
                          widget.account!.note,
                        )
                      : _addNewAccount(
                          _titleController.text,
                          _usernameController.text,
                          _passwordController.text,
                          _noteController.text,
                        );
                },
                width: 1,
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

  _addNewAccount(title, username, password, note) {
    AccountProvider accountProvider =
        Provider.of<AccountProvider>(context, listen: false);

    if (title == '' || username == '' || password == '') {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập đầy đủ thông tin',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
    } else {
      accountProvider
          .createNewAccount(title, username, password, note)
          .then((response) {
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

  _updateAccount(id, title, username, password, note) {
    AccountProvider accountProvider =
        Provider.of<AccountProvider>(context, listen: false);

    accountProvider.updateAlbum(id, title, username, password, note).then(
      (response) {
        if (response['status']) {
          Navigator.pop(context);
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.green,
          );
        } else {
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.redAccent,
          );
        }
      },
    );
  }
}
