import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/screens/screens.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import 'widgets/widgets.dart';
import 'widgets/toast.dart' as toast;

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LoginScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    _login(phone, pass) {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = RegExp(pattern);
      if (phone == '' || pass == '') {
        fToast.showToast(
          child: const toast.Toast(
            icon: Icons.error,
            color: Colors.redAccent,
            message: 'Vui lòng nhập đầy đủ thông tin',
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      } else if (!regExp.hasMatch(phone)) {
        fToast.showToast(
          child: const toast.Toast(
            icon: Icons.error,
            color: Colors.redAccent,
            message: 'Số điện thoại không đúng định dạng',
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      } else {
        final Future<Map<String, dynamic>> successfulMessage =
            auth.login(phone, pass);

        successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
            fToast.showToast(
              child: const toast.Toast(
                icon: Icons.check,
                color: Colors.green,
                message: 'Đăng nhập thành công',
              ),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 2),
            );
          } else {
            fToast.showToast(
              child: const toast.Toast(
                icon: Icons.error,
                color: Colors.redAccent,
                message: 'SĐT hoặc Mật khẩu không chính xác',
              ),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 2),
            );
          }
        });
      }
    }

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/text_logo.png',
                width: MediaQuery.of(context).size.width / 3.3,
              ),
              Image.asset(
                "assets/images/book.gif",
                height: size.height * 0.3,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                controller: phoneController,
                hintText: "Số điện thoại",
                onChanged: (value) => {},
              ),
              RoundedPasswordField(
                controller: passwordController,
                hintText: 'Mật khẩu',
                onChanged: (value) => {},
              ),
              auth.loggedInStatus == Status.authenticating
                  ? const ColorLoader()
                  : RoundedButton(
                      width: 0.8,
                      text: "ĐĂNG NHẬP",
                      onPressed: () {
                        _login(phoneController.text, passwordController.text);
                      },
                    ),
              SizedBox(
                width: size.width * 0.8,
                height: size.width * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, ForgotPasswordScreen.routeName);
                      },
                      child: const Text(
                        'Quên mật khẩu?',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              AlreadyHaveAnAccountCheck(
                textLeft: "Bạn chưa có tài khoản ? ",
                textRight: "Đăng kí",
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RegisterScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
