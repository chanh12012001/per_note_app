import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/user_model.dart';
import 'package:per_note/screens/screens.dart';

class ScreenNavigation extends StatefulWidget {
  final User user;
  const ScreenNavigation({Key? key, required this.user}) : super(key: key);

  @override
  State<ScreenNavigation> createState() => _ScreenNavigationState();
}

class _ScreenNavigationState extends State<ScreenNavigation> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final _pageOption = [
      HomeScreen(user: widget.user),
      const ScheduleScreen(),
      const AssetManageScreen(),
      const HealthManageScreen(),
    ];

    return Scaffold(
      body: _pageOption[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: whiteColor,
        activeColor: tealColor,
        color: grey2Color,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.schedule, title: 'Kế hoạch'),
          TabItem(icon: Icons.storage, title: 'Lưu trữ'),
          TabItem(icon: Icons.health_and_safety, title: 'Sức khoẻ'),
        ],
        initialActiveIndex: selectedPage,
        onTap: (int index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
