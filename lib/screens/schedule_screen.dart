import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/config/theme.dart';

class ScheduleScreen extends StatelessWidget {
  static const String routeName = '/schedule';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ScheduleScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Lập kế hoạch',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(DateTime.now()),
                      style: subHeadingStyle,
                    ),
                    Text(
                      'Hôm nay',
                      style: headingStyle,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
