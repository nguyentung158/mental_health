import 'package:flutter/material.dart';
import 'package:mental_health_app/screens/auth_screens/sign_up_flow_screens/age_slide.dart';
import 'package:mental_health_app/screens/auth_screens/sign_up_flow_screens/genders_slide.dart';
import 'package:mental_health_app/widgets/auth_button.dart';

class FlowSignUpScreen extends StatefulWidget {
  static String route = '/sign0';
  FlowSignUpScreen({super.key});

  @override
  State<FlowSignUpScreen> createState() => _FlowSignUpScreenState();
}

class _FlowSignUpScreenState extends State<FlowSignUpScreen> {
  int genders = 2;
  int age = 8;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  int _cunrruntPage = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  void setGender(int val) {
    genders = val;
  }

  void setAge(int val) {
    age = val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 5,
                decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ))),
            Container(
                width: (MediaQuery.of(context).size.width / 2) /
                    6 *
                    (_cunrruntPage + 1),
                height: 5,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ))),
          ],
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    _cunrruntPage = value;
                  });
                },
                children: [
                  GenderSlide(
                    genders: genders,
                    setGender: setGender,
                  ),
                  AgeSlide(
                    age: age,
                    setAge: setAge,
                  ),
                  GenderSlide(
                    setGender: setGender,
                    genders: genders,
                  ),
                  GenderSlide(
                    setGender: setGender,
                    genders: genders,
                  ),
                  GenderSlide(
                    setGender: setGender,
                    genders: genders,
                  ),
                  GenderSlide(
                    setGender: setGender,
                    genders: genders,
                  ),
                ],
              ),
            ),
            InkWell(
              child: AuthButton(
                  title: _cunrruntPage == 5 ? 'Sign up' : 'Continue',
                  color: Colors.white),
              onTap: () {
                if (_cunrruntPage < 5) {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear);
                  setState(() {
                    _cunrruntPage++;
                  });
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 32,
            )
          ],
        ),
      ),
    );
  }
}
