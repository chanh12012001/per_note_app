import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../models/user_model.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userId!);
    prefs.setString("phoneNumber", user.phoneNumber!);
    prefs.setString("name", user.name!);
    prefs.setString("dateOfBirth", user.dateOfBirth!);
    prefs.setString("sex", user.sex!);
    prefs.setString("email", user.email!);
    if (user.token != null) prefs.setString("token", user.token!);
    prefs.setString("avatarUrl", user.avatarUrl!);
    prefs.setString("cloudinaryId", user.cloudinaryId!);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString("userId");
    String? phoneNumber = prefs.getString("phoneNumber");
    String? name = prefs.getString("name");
    String? dateOfBirth = prefs.getString("dateOfBirth");
    String? sex = prefs.getString("sex");
    String? email = prefs.getString("email");
    String? token = prefs.getString("token");
    String? avatarUrl = prefs.getString("avatarUrl");
    String? cloudinaryId = prefs.getString("cloudinaryId");

    return User(
      userId: userId,
      phoneNumber: phoneNumber,
      name: name,
      dateOfBirth: dateOfBirth,
      sex: sex,
      email: email,
      token: token,
      avatarUrl: avatarUrl,
      cloudinaryId: cloudinaryId,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("userId");
    prefs.remove("phoneNumber");
    prefs.remove("name");
    prefs.remove("dateOfBirth");
    prefs.remove("sex");
    prefs.remove("email");
    prefs.remove("token");
    prefs.remove("avatarUrl");
    prefs.remove("cloudinaryId");
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token!;
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    return userId!;
  }
}
