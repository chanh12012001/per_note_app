import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:per_note/screens/screens.dart';
import 'package:per_note/screens/widgets/widgets.dart';
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
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    _register(password, confirmPassword) {
      if (password == '') {
        fToast.showToast(
          child: const toast.Toast(
            icon: Icons.error,
            color: Colors.redAccent,
            message: 'Vui lòng nhập mật khẩu',
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      } else if (confirmPassword == '') {
        fToast.showToast(
          child: const toast.Toast(
            icon: Icons.error,
            color: Colors.redAccent,
            message: 'Vui lòng xác nhận mật khẩu',
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      } else if (confirmPassword != password) {
        fToast.showToast(
          child: const toast.Toast(
            icon: Icons.error,
            color: Colors.redAccent,
            message: 'Mật khẩu xác nhận không chính xác',
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      } else {
        final Future<Map<String, dynamic>> successfulMessage =
            auth.register(password);

        successfulMessage.then((response) {
          if (response['status']) {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.routeName, (route) => false);
            fToast.showToast(
              child: const toast.Toast(
                icon: Icons.check,
                color: Colors.green,
                message: 'Đăng ký thành công',
              ),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 2),
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
