import 'package:flutter/material.dart';
import 'package:per_note/screens/widgets/background.dart';
import 'widgets/already_have_an_account.dart';
import 'widgets/rounded_button.dart';
import 'widgets/rounded_input_field.dart';
import 'widgets/rounded_password_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LoginScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                "assets/images/3.gif",
                height: size.height * 0.3,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Số điện thoại",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "ĐĂNG NHẬP",
                onPressed: () {},
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
