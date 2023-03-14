import 'package:flutter/material.dart';
import 'package:mental_health_app/widgets/text_field.dart';

class SignUpSlide extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController rePassword;

  const SignUpSlide(
      {super.key,
      required this.email,
      required this.password,
      required this.rePassword});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create an Account',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Enter your email & password. If you forget it. then you have to do forgot password",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: deviceSize.height / 40,
              width: double.infinity,
            ),
            Text(
              'Email',
              style: Theme.of(context).textTheme.headline6,
            ),
            MyTextField(
              textEditingController: email,
              hintText: 'Enter your email',
              obscureText: false,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: deviceSize.height / 40,
              width: double.infinity,
            ),
            Text(
              'Password',
              style: Theme.of(context).textTheme.headline6,
            ),
            MyTextField(
              textEditingController: password,
              hintText: 'Enter your password',
              obscureText: true,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: deviceSize.height / 40,
              width: double.infinity,
            ),
            Text(
              'Confirm password',
              style: Theme.of(context).textTheme.headline6,
            ),
            MyTextField(
              textEditingController: rePassword,
              hintText: 'Confirm your password',
              obscureText: true,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: deviceSize.height / 40,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
