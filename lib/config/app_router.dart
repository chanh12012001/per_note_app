import 'package:flutter/material.dart';
import 'package:per_note/screens/widgets/task_to_do/category_screen.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import '../screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      // case HomeScreen.routeName:
      //   return HomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case RegisterScreen.routeName:
        return RegisterScreen.route();
      case OtpVerificationScreen.routeName:
        return OtpVerificationScreen.route();
      case InputPasswordScreen.routeName:
        return InputPasswordScreen.route();
      case ForgotPasswordScreen.routeName:
        return ForgotPasswordScreen.route();
      case ScheduleScreen.routeName:
        return ScheduleScreen.route();
      case FinancialScreen.routeName:
        return FinancialScreen.route();
      case AddTaskScreen.routeName:
        return AddTaskScreen.route();
      case AssetManageScreen.routeName:
        return AssetManageScreen.route();
      case HealthManageScreen.routeName:
        return HealthManageScreen.route();
      case CategoryScreen.routeName:
        return CategoryScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('error')),
      ),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
