import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/screens/screens.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:per_note/services/notification_service.dart';
import '../preferences/user_preference.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notifyService = NotificationService();

  @override
  void initState() {
    super.initState();
    notifyService.initializeNotification();
    notifyService.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        elevation: 0.1,
        leading: const Icon(Icons.person),
        actions: [
          GestureDetector(
            onTap: () {
              UserPreferences().removeUser();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          FutureBuilder(
            future: UserPreferences().getUserId(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(child: Text('null'));
              }
              return Center(child: Text('${snapshot.data}'));
            },
          ),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
            onPressed: () {
              notifyService.displayNotification(
                title: 'Notification App',
                body: 'Day di hoc de',
              );
            },
            child: const Text('Push Notification'),
          ),
          const SizedBox(
            height: 80,
          ),
          RoundedButton(
            text: 'Schedule',
            onPressed: () {
              Navigator.pushNamed(context, ScheduleScreen.routeName);
            },
            width: 0.3,
          ),
          const SizedBox(
            height: 80,
          ),
          RoundedButton(
            text: 'Finacial',
            color: Color.fromARGB(255, 13, 75, 45),
            onPressed: () {
              Navigator.pushNamed(context, FinancialScreen.routeName);
            },
            width: 0.3,
          ),
        ],
      ),
    );
  }
}
