import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  User _user = User();
  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  String _phone = '';
  String get phone => _phone;

  void setPhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  String _hashDataOtp = '';
  String get hashDataOtp => _hashDataOtp;

  void setHashDataOtp(String hashDataOtp) {
    _hashDataOtp = hashDataOtp;
    notifyListeners();
  }
}
