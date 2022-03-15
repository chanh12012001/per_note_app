import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ToastService {
  Future showToast({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color backgroundColor,
  }) {
    return Flushbar(
      margin: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      borderRadius: BorderRadius.circular(20),
      backgroundColor: backgroundColor,
      message: message,
      icon: Icon(
        icon,
        size: 28.0,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 2),
    ).show(context);
  }
}
