import 'package:flutter/material.dart';
import 'package:per_note/screens/screens.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:per_note/services/toast_service.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'widgets/toast.dart' as toast;

class InputPasswordScreen extends StatefulWidget {
  static const String routeName = '/input-password';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const InputPasswordScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const InputPasswordScreen({Key? key}) : super(key: key);

  @override
  State<InputPasswordScreen> createState() => _InputPasswordScreenState();
}

class _InputPasswordScreenState extends State<InputPasswordScreen> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    _register(password, confirmPassword) {
      if (password == '') {
        toast.showToast(
          context: context,
          message: 'Vui lòng nhập mật khẩu',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
        );
      } else if (confirmPassword == '') {
        toast.showToast(
          context: context,
          message: 'Vui lòng xác nhận mật khẩu',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
        );
      } else if (confirmPassword != password) {
        toast.showToast(
          context: context,
          message: 'Mật khẩu xác nhận không chính xác',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
        );
      } else {
        final Future<Map<String, dynamic>> successfulMessage =
            auth.register(password);

        successfulMessage.then((response) {
          if (response['status']) {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.routeName, (route) => false);
            toast.showToast(
              context: context,
              message: 'Đăng ký thành công',
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
        });
      }
    }

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/key.jpeg',
              width: size.width / 1.5,
            ),
            const Text(
              'Nhập mật khẩu mới',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 25, 133, 133),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundedPasswordField(
              controller: _passwordController,
              hintText: 'Mật khẩu',
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: _confirmPasswordController,
              hintText: 'Xác nhận mật khẩu',
              onChanged: (value) {},
            ),
            auth.registeredStatus == Status.registering
                ? const ColorLoader()
                : RoundedButton(
                    width: 0.8,
                    text: "TIẾP TỤC",
                    onPressed: () {
                      _register(_passwordController.text,
                          _confirmPasswordController.text);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
