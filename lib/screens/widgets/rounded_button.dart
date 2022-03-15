import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? color, textColor;
  final double width;
  final double height;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    required this.width,
    this.height = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}
