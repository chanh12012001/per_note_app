import 'package:flutter/material.dart';

class OtherLoginMethod extends StatelessWidget {
  final Color borderColor;
  final String image;
  final String text;
  final Color textColor;
  final Function onTap;
  const OtherLoginMethod(
      {Key? key,
      required this.borderColor,
      required this.image,
      required this.text,
      required this.textColor, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: size.height * 0.05,
          width: text.length < 8 ? size.width * 0.25 : size.width * 0.28,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: borderColor)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
