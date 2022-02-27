import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'widgets.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String hintText;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool onVisibility = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        obscureText: onVisibility,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            hintText: widget.hintText,
            icon: const Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: GestureDetector(
              child: Icon(
                onVisibility ? Icons.visibility_off : Icons.visibility,
                color: kPrimaryColor,
              ),
              onTap: () {
                setState(() {
                  onVisibility = !onVisibility;
                });
              },
            ),
            border: InputBorder.none),
      ),
    );
  }
}
