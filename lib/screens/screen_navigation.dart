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

class _ScreenNavigationState extends State<ScreenNavigation>
    with SingleTickerProviderStateMixin {
  int selectedPage = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: 0); // đặt initialIndex tại đây
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: [
            HomeScreen(user: widget.user),
            const ScheduleScreen(),
            const AssetManageScreen(),
            const HealthManageScreen(),
          ],
        ),
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
          controller: _tabController,
          // onTap: (int index) {
          //   setState(() {
          //     selectedPage = index;
          //   });
          // },
        ),
      ),
    );
  }
}
