import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../config/app_url_config.dart';
import '../models/user_model.dart';
import '../preferences/user_preference.dart';
import '../repositories/auth_repository.dart';

enum Status {
  notLoggedIn,
  loggedIn,
  authenticating,

  loggedOut,

  notSentOtp,
  sendingOtp,
  sentOtp,

  notVerifyOTP,
  verifyingOTP,
  verifiedOTP,

  notRegistered,
  registering,
  registered,
}

class AuthProvider with ChangeNotifier {
  AuthRepository authRepository = AuthRepository();

  Status _loggedInStatus = Status.notLoggedIn;
  Status _sentOtpStatus = Status.notSentOtp;
  Status _verifyOtpStatus = Status.notVerifyOTP;
  Status _registeredStatus = Status.notRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get sentOtpStatus => _sentOtpStatus;
  Status get verifyOtpStatus => _verifyOtpStatus;
  Status get registeredStatus => _registeredStatus;

  Future<Map<String, dynamic>> login(
      String phoneNumber, String password) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> loginData = {
      'phoneNumber': phoneNumber,
      'password': password
    };

    _loggedInStatus = Status.authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.login),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData;

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.loggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful',
        'user': authUser,
      };
    } else {
      _loggedInStatus = Status.notLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> googleLogin(String email) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> loginData = {
      'email': email
    };

    _loggedInStatus = Status.authenticating;
    notifyListeners();
    Response response = await post(
      Uri.parse(AppUrl.googleLogin),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData;

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.loggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful',
        'user': authUser,
      };
    } else {
      _loggedInStatus = Status.notLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> createNewOTP(String phoneNumber) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> phoneData = {
      'phone': phoneNumber,
    };

    _sentOtpStatus = Status.sendingOtp;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.otpRegister),
      body: json.encode(phoneData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      _sentOtpStatus = Status.sentOtp;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful',
        'data': responseData['data']
      };
    } else {
      _sentOtpStatus = Status.notSentOtp;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> verifyOTP(phone, otp, hashData) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> verifyOtpData = {
      'phone': phone,
      'otp': otp,
      'hash': hashData,
    };

    _verifyOtpStatus = Status.verifyingOTP;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.verifyOTP),
      body: json.encode(verifyOtpData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _verifyOtpStatus = Status.verifiedOTP;
      notifyListeners();

      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
      };
    } else {
      _verifyOtpStatus = Status.notVerifyOTP;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(password) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> passwordData = {
      'password': password,
    };

    _registeredStatus = Status.registering;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.register),
      body: json.encode(passwordData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _registeredStatus = Status.registered;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful',
      };
    } else if (response.statusCode == 400) {
      _registeredStatus = Status.notRegistered;
      notifyListeners();

      result = {
        'status': false,
        'message': 'Số điện thoại chưa được xác thực',
      };
    } else {
      _registeredStatus = Status.notRegistered;
      notifyListeners();

      result = {'status': false, 'message': json.decode(response.body)};
    }
    return result;
  }

  Future<Map<String, dynamic>> registerGoogle(
      String? name, String? email, String? photo) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> userData = {
      'name': name,
      'email': email,
      'avatarUrl': photo
    };

    _registeredStatus = Status.registering;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.registerGoogle),
      body: json.encode(userData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _registeredStatus = Status.registered;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful',
      };
    } else if (response.statusCode == 400) {
      _registeredStatus = Status.notRegistered;
      notifyListeners();

      result = {
        'status': false,
        'message': 'Tài khoản đã được đăng ký',
      };
    } else {
      _registeredStatus = Status.notRegistered;
      notifyListeners();

      result = {'status': false, 'message': json.decode(response.body)};
    }
    return result;
  }

  Future<Map<String, dynamic>> forgotPassword(phoneNumber) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> phoneData = {
      'phoneNumber': phoneNumber,
    };

    _sentOtpStatus = Status.sendingOtp;
    notifyListeners();

    Response response = await put(
      Uri.parse(AppUrl.forgotPassword),
      body: json.encode(phoneData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _sentOtpStatus = Status.sentOtp;
      notifyListeners();

      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
      };
    } else if (response.statusCode == 400) {
      _sentOtpStatus = Status.notSentOtp;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['message'],
      };
    } else {
      _sentOtpStatus = Status.notSentOtp;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['message'],
      };
    }
    return result;
  }

  Future<User> updateAvatar(userId, File imageFile) async {
    User user = await authRepository.updateAvatar(userId, imageFile);
    await UserPreferences().saveUser(user);
    notifyListeners();
    return user;
  }

  Future<User> updateUserInfo(userId, name, sex, email) async {
    User user = await authRepository.updateUserInfo(userId, name, sex, email);
    await UserPreferences().saveUser(user);
    notifyListeners();
    return user;
  }

// Future<void> signInWithGoogle() async {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//   try {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

//     // Lấy thông tin từ tài khoản Google
//     final String? email = googleUser.email;
//     final String? displayName = googleUser.displayName;
//     final String? idToken = googleAuth.idToken; // Sử dụng khi cần xác thực server-side

//     // Lưu trữ thông tin đăng nhập
//     saveUserInfo(email, displayName);

//     // Tiếp tục xử lý đăng nhập hoặc chuyển hướng đến màn hình tiếp theo
//     // ...
//   } catch (error) {
//     print('Đăng nhập bằng Google thất bại: $error');
//   }
// }

// void saveUserInfo(String? email, String? displayName) {
//   // Lưu trữ thông tin người dùng sau khi đăng nhập
//   // Có thể sử dụng Shared Preferences hoặc Flutter Secure Storage như đã trình bày trong câu trả lời trước
// }
}
