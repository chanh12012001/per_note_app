import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final String textLeft;
  final String textRight;
  final Function onTap;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    required this.textLeft,
    required this.textRight,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          textLeft,
          style: const TextStyle(color: kPrimaryColor, fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Text(
            textRight,
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
