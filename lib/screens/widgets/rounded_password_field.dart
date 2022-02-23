import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
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
        obscureText: onVisibility,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            hintText: "Mật khẩu",
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
