import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:per_note/screens/Financal_page/add_spending.dart';
import 'package:per_note/screens/Financal_page/daily_payment.dart';

class FinancialScreen extends StatefulWidget {
  static const String routeName = '/financial';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const FinancialScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const FinancialScreen({Key? key}) : super(key: key);

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: finanBody(),
      bottomNavigationBar: finanFooter(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setTabs(2);
        },
        child: IconButton(
          icon: Icon(Icons.add),
          iconSize: 25,
          onPressed: () => showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            context: context,
            builder: (context) => const addSpending(),
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget finanBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        DailyPayment(),
        Center(
          child: Text('Báo cáo'),
        ),
        Center(
          child: Text('Thêm ví tiền'),
        ),
      ],
    );
  }

  Widget finanFooter() {
    List<IconData> iconItems = [
      Icons.attach_money,
      Icons.data_thresholding,
    ];
    return AnimatedBottomNavigationBar(
        icons: iconItems,
        activeColor: Colors.blueAccent,
        splashColor: Colors.grey,
        inactiveColor: Colors.black.withOpacity(0.2),
        activeIndex: pageIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 15,
        iconSize: 25,
        rightCornerRadius: 10,
        onTap: (index) {
          setTabs(index);
        });
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }

  
}
