import 'dart:async';
import 'package:flutter/material.dart';
import 'package:per_note/screens/screens.dart';
import '../models/user_model.dart';
import '../preferences/user_preference.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SplashScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );

  Future<User> getUserData() => UserPreferences().getUser();

  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () => {
        getUserData().then((value) => value.token == null
            ? Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.routeName, (route) => false)
            : Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false)),
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            ScaleTransition(
              scale: _animation,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo.png'),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/text_logo.png',
                        width: MediaQuery.of(context).size.width / 3.3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            const Text(
              "from",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_uit.png',
                  width: MediaQuery.of(context).size.width / 9,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "UIT",
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 107, 255),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
