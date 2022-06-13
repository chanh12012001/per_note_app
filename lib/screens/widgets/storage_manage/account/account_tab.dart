import 'package:flutter/material.dart';
import 'package:per_note/models/account_model.dart';
import 'package:per_note/preferences/user_preference.dart';
import 'package:per_note/providers/account_provider.dart';
import 'package:per_note/screens/widgets/storage_manage/account/account_add_edit.dart';
import 'package:per_note/screens/widgets/storage_manage/account/input_password_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../config/theme.dart';
import 'package:per_note/services/toast_service.dart';

import '../../../../models/user_model.dart';
import '../../../../providers/auth_provider.dart';
import '../../loader.dart';
import 'account_list.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  ToastService toast = ToastService();
  UserPreferences userPreferences = UserPreferences();
  final TextEditingController _passwordController = TextEditingController();
  bool flag = false;

  @override
  void initState() {
    super.initState();
    flag == false
        ? Future.delayed(Duration.zero, () {
            _showDialogInputPassword();
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    AccountProvider accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      floatingActionButton: flag
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const AddAndEditAccount();
                  },
                ));
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_box),
            )
          : null,
      body: flag == false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                      left: 50,
                      bottom: 20,
                      right: 50,
                    ),
                    child: Text(
                      "Vui lòng nhập mật khẩu để sử dụng chức năng",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    child: const Text("Nhập mật khẩu"),
                    onPressed: () {
                      _showDialogInputPassword();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            )
          : FutureBuilder<List<Account>>(
              future: accountProvider.getAccountsList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return snapshot.hasData
                    ? AccountList(accounts: snapshot.data!)
                    : const Center(
                        child: ColorLoader(),
                      );
              },
            ),
    );
  }

  _showDialogInputPassword() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder<User>(
            future: userPreferences.getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return snapshot.hasData
                  ? InputPasswordDialog(
                      controller: _passwordController,
                      title: "Vui lòng nhập mật khẩu để tiếp tục",
                      action: () {
                        _passwordAuthentication(snapshot.data!.phoneNumber,
                            _passwordController.text);
                      },
                    )
                  : Container();
            },
          );
        });
  }

  _passwordAuthentication(phone, pass) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    if (pass == '') {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập mật khẩu',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
    } else {
      final Future<Map<String, dynamic>> successfulMessage =
          auth.login(phone, pass);

      successfulMessage.then((response) async {
        if (response['status']) {
          Navigator.pop(context);
          setState(() {
            flag = true;
          });
        } else {
          toast.showToast(
            context: context,
            message: 'Mật khẩu không chính xác',
            icon: Icons.error,
            backgroundColor: Colors.redAccent,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }
}
