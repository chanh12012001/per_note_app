import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function onTap;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Bạn chưa có tài khoản ? " : "Bạn đã có tài khoản ? ",
          style: const TextStyle(color: kPrimaryColor, fontSize: 16),
        ),
        GestureDetector(
          onTap: onTap(),
          child: Text(
            login ? "Đăng kí" : "Đăng nhập",
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
