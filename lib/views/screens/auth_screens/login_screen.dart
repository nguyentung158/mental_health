import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/auth_controller.dart';
import 'package:mental_health_app/views/widgets/auth_button.dart';
import 'package:mental_health_app/views/widgets/text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String route = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  void _showSnackBar(String title, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello there',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(
                      height: deviceSize.height / 40,
                      width: double.infinity,
                    ),
                    Text(
                      'Please enter your email and password to login',
                      style: Theme.of(context).textTheme.bodyText2,
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
                      'Forgot Password',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
                onTap: () async {
                  if (email.text == '' || password.text == '') {
                    _showSnackBar('Please enter all the fields', context);
                    return;
                  }
                  await Provider.of<AuthController>(context, listen: false)
                      .login(email.text, password.text);
                },
                child: const AuthButton(title: 'Login', color: Colors.white)),
            SizedBox(
              height: deviceSize.height / 32,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
