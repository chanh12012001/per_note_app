import 'package:flutter/material.dart';
import 'package:per_note/config/colors.dart';
import 'package:per_note/config/dimens.dart';
import 'package:per_note/config/text_style.dart';

class TextFieldBase extends StatelessWidget {
  final String? label;
  final String hintText;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final String? errorText;
  const TextFieldBase(
      {key,
      this.label,
      this.controller,
      required this.hintText,
      this.suffix,
      this.onChanged,
      this.obscureText = false,
      this.errorText,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null) ...[
          Text(
            label!,
            style: TextStyleApp.defaut_s14_w6_black1F1F1F.style,
          ),
        ],
        const SizedBox(height: AppDimens.size5),
        TextFormField(
          controller: controller,
          obscureText: obscureText!,
          cursorColor: AppColor.grey_737373,
          style: TextStyleApp.defaut_s14_w4_grey737373.style,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyleApp.defaut_s14_w4_grey737373.style,
            suffixIcon: suffix,
            prefixIcon: prefix,
            contentPadding: const EdgeInsets.symmetric(
                vertical: AppDimens.size10, horizontal: AppDimens.size10),
            focusedBorder: _border(),
            enabledBorder: _border(),
            border: _border(),
            errorText: errorText,
          ),
          onChanged: onChanged,
        )
      ],
    );
  }

  InputBorder _border() {
    return OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColor.black_1F1F1F.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(AppDimens.size4));
  }
}
