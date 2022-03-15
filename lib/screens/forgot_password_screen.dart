import 'package:flutter/material.dart';
import 'package:per_note/providers/auth_provider.dart';
import 'package:per_note/screens/screens.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:per_note/services/toast_service.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';

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
  ToastService toast = ToastService();

  @override
  void initState() {
    super.initState();
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
        toast.showToast(
          context: context,
          message: 'Vui lòng nhập số điện thoại để tiếp tục',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
        );
      } else if (!regExp.hasMatch(phoneNumber)) {
        toast.showToast(
          context: context,
          message: 'Số điện thoại không đúng định dạng',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
        );
      } else {
        final Future<Map<String, dynamic>> successfulMessage =
            auth.forgotPassword(phoneNumber);

        successfulMessage.then(
          (response) {
            if (response['status']) {
              Navigator.pushNamed(context, LoginScreen.routeName);
              toast.showToast(
                context: context,
                message: 'Mật khẩu mới đã được gửi đến $phoneNumber',
                icon: Icons.check,
                backgroundColor: Colors.green,
              );
            } else {
              toast.showToast(
                context: context,
                message: response['message'],
                icon: Icons.error,
                backgroundColor: Colors.redAccent,
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
