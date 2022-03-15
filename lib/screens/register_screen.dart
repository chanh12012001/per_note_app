import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:per_note/services/toast_service.dart';
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
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;

    _createNewOtp(phone) {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = RegExp(pattern);

      if (phone == '') {
        toast.showToast(
          context: context,
          message: 'Vui lòng nhập số điện thoại để tiếp tục',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
        );
      } else if (!regExp.hasMatch(phone)) {
        toast.showToast(
          context: context,
          message: 'Số điện thoại không đúng định dạng',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
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
              toast.showToast(
                context: context,
                message: 'SĐT đã được đăng kí bởi người khác',
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
