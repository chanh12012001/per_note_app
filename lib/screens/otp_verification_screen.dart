import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/providers/auth_provider.dart';
import 'package:per_note/screens/screens.dart';
import 'package:per_note/services/toast_service.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'widgets/widgets.dart';
import 'widgets/toast.dart' as toast;

class OtpVerificationScreen extends StatefulWidget {
  static const String routeName = '/otp-verification';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const OtpVerificationScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);
    String phone = Provider.of<UserProvider>(context).phone;
    String hashDataOtp = Provider.of<UserProvider>(context).hashDataOtp;
    String? otp;

    _verifyOTP(phone, otp, hashDataOtp) {
      if (otp == '') {
        toast.showToast(
          context: context,
          message: 'Vui lòng nhập OTP',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
        );
      } else {
        final Future<Map<String, dynamic>> successfulMessage =
            auth.verifyOTP(phone, otp, hashDataOtp);

        successfulMessage.then((response) {
          if (response['status']) {
            Provider.of<UserProvider>(context, listen: false).setPhone(phone);
            Navigator.pushNamedAndRemoveUntil(
                context, InputPasswordScreen.routeName, (route) => false);
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
            Lottie.asset(
              'assets/json/otpverification.json',
              height: size.height * 0.35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Vui lòng nhập mã gồm 4 chữ số được gửi đến $phone',
                style: const TextStyle(
                  color: Color.fromARGB(255, 121, 94, 13),
                  fontSize: 18,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.13, right: size.width * 0.13),
              child: Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onCompleted: (pin) => otp = pin,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            AlreadyHaveAnAccountCheck(
              textLeft: "Tôi chưa nhận được mã. ",
              textRight: "Gửi lại",
              onTap: () {
                _verifyOTP(phone, otp, hashDataOtp);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            auth.verifyOtpStatus == Status.verifyingOTP
                ? const ColorLoader()
                : RoundedButton(
                    width: 0.8,
                    text: 'XÁC THỰC',
                    onPressed: () {
                      // Navigator.pushNamedAndRemoveUntil(context,
                      //     InputPasswordScreen.routeName, (route) => false);

                      _verifyOTP(phone, otp, hashDataOtp);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: kPrimaryColor),
    borderRadius: BorderRadius.circular(20),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: const Color.fromRGBO(234, 239, 243, 1),
  ),
);
