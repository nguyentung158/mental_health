import 'package:flutter/material.dart';
import 'package:mental_health_app/views/screens/auth_screens/login_screen.dart';
import 'package:mental_health_app/views/screens/auth_screens/sign_up_flow_screens/flow_sign_up_screen.dart';
import 'package:mental_health_app/views/widgets/auth_button.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Image.asset(
                'assets/images/get_started_icon.png',
                fit: BoxFit.contain,
              )),
              Text(
                'Welcome to Calmy',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: deviceSize.height / 20,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                child: Text(
                  'The best mental health app to keep you calm and stay focused',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              SizedBox(
                height: deviceSize.height / 25,
                width: double.infinity,
              ),
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(FlowSignUpScreen.route),
                child: AuthButton(
                  title: 'Get Started',
                  color: Colors.white,
                  backGroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(LoginScreen.route),
                child: AuthButton(
                  title: 'I Already Have an Account',
                  color: Theme.of(context).colorScheme.primary,
                  backGroundColor: Colors.white,
                ),
              ),
              SizedBox(
                height: deviceSize.height / 32,
                width: double.infinity,
              )
            ]),
      ),
    );
  }
}
