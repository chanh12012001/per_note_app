import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import 'screens.dart';
import 'widgets/widgets.dart';
import 'widgets/toast.dart' as toast;

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const RegisterScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final phoneController = TextEditingController();
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;

    _createNewOtp(phone) {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = RegExp(pattern);

      if (phone == '') {
        fToast.showToast(
          child: const toast.Toast(
            icon: Icons.error,
            color: Colors.redAccent,
            message: 'Vui lòng nhập số điện thoại để tiếp tục',
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
            auth.createNewOTP(phoneController.text);

        successfulMessage.then(
          (response) {
            if (response['status']) {
              String phoneNumber = phone;
              String hashData = response['data'];
              Provider.of<UserProvider>(context, listen: false)
                  .setPhone(phoneNumber);
              Provider.of<UserProvider>(context, listen: false)
                  .setHashDataOtp(hashData);
              Navigator.pushNamed(context, OtpVerificationScreen.routeName);
            } else {
              fToast.showToast(
                child: const toast.Toast(
                  icon: Icons.error,
                  color: Colors.redAccent,
                  message: 'SĐT đã được đăng kí bởi người khác',
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
            Lottie.asset(
              'assets/json/otp.json',
              width: size.width,
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Vui lòng nhập số điện thoại để tiếp tục.',
                style: TextStyle(fontSize: 17, color: Colors.red),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedInputField(
              controller: phoneController,
              hintText: 'Số điện thoại',
              onChanged: (value) {},
            ),
            auth.sentOtpStatus == Status.sendingOtp
                ? const ColorLoader()
                : RoundedButton(
                    width: 0.8,
                    text: 'TIẾP TỤC',
                    onPressed: () {
                      _createNewOtp(phoneController.text);
                      // Navigator.pushNamed(
                      //     context, OtpVerificationScreen.routeName);
                    },
                  ),
            const SizedBox(
              height: 25,
            ),
            AlreadyHaveAnAccountCheck(
              textLeft: "Bạn đã có tài khoản ? ",
              textRight: "Đăng nhập",
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
