import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:per_note/providers/auth_provider.dart';
import 'package:per_note/screens/screens.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import 'widgets/toast.dart' as toast;

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ForgotPasswordScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
    TextEditingController _phoneController = TextEditingController();
    AuthProvider auth = Provider.of<AuthProvider>(context);

    _forgotPassword(phoneNumber) {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = RegExp(pattern);

      if (phoneNumber == '') {
        fToast.showToast(
          child: const toast.Toast(
            icon: Icons.error,
            color: Colors.redAccent,
            message: 'Vui lòng nhập số điện thoại để tiếp tục',
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      } else if (!regExp.hasMatch(phoneNumber)) {
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
            auth.forgotPassword(phoneNumber);

        successfulMessage.then(
          (response) {
            if (response['status']) {
              Navigator.pushNamed(context, LoginScreen.routeName);
              fToast.showToast(
                child: toast.Toast(
                  icon: Icons.check,
                  color: Colors.green,
                  message: 'Mật khẩu mới đã được gửi đến $phoneNumber',
                ),
                gravity: ToastGravity.BOTTOM,
                toastDuration: const Duration(seconds: 3),
              );
            } else {
              fToast.showToast(
                child: toast.Toast(
                  icon: Icons.error,
                  color: Colors.redAccent,
                  message: response['message'],
                ),
                gravity: ToastGravity.BOTTOM,
                toastDuration: const Duration(seconds: 2),
              );
            }
          },
        );
      }
    }

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Lấy lại mật khẩu',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Color.fromARGB(255, 16, 148, 153),
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
            ),
            Image.asset(
              'assets/images/forgot_password.png',
              width: size.width / 1.1,
            ),
            SizedBox(
              width: size.width * 0.8,
              height: size.width * 0.14,
              child: const Text(
                'Vui lòng nhập số điện thoại muốn lấy lại mật khẩu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                ),
              ),
            ),
            RoundedInputField(
              hintText: 'Số điện thoại',
              onChanged: (value) {},
              controller: _phoneController,
            ),
            auth.sentOtpStatus == Status.sendingOtp
                ? const ColorLoader()
                : RoundedButton(
                    width: 0.8,
                    text: 'TIẾP TỤC',
                    onPressed: () {
                      _forgotPassword(_phoneController.text);
                    },
                  ),
            SizedBox(
              height: size.height * 0.1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: const Text(
                'Quay lại trang đăng nhập',
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
