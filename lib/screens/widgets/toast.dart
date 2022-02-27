import 'package:flutter/material.dart';

class Toast extends StatefulWidget {
  final String message;
  final Color color;
  final IconData icon;
  const Toast({
    Key? key,
    required this.message,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  State<Toast> createState() => _ToastState();
}

class _ToastState extends State<Toast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: widget.color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            widget.message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
