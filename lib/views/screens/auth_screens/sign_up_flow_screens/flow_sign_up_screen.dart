import 'package:flutter/material.dart';
import 'package:mental_health_app/constant.dart';
import 'package:mental_health_app/controllers/auth_controller.dart';
import 'package:mental_health_app/views/screens/auth_screens/sign_up_flow_screens/age_slide.dart';
import 'package:mental_health_app/views/screens/auth_screens/sign_up_flow_screens/genders_slide.dart';
import 'package:mental_health_app/views/screens/auth_screens/sign_up_flow_screens/goal_slide.dart';
import 'package:mental_health_app/views/screens/auth_screens/sign_up_flow_screens/profile_slide.dart';
import 'package:mental_health_app/views/screens/auth_screens/sign_up_flow_screens/signup_slide.dart';
import 'package:mental_health_app/views/screens/auth_screens/sign_up_flow_screens/time_slide.dart';
import 'package:mental_health_app/views/widgets/auth_button.dart';
import 'package:provider/provider.dart';

class FlowSignUpScreen extends StatefulWidget {
  static String route = '/sign0';
  const FlowSignUpScreen({super.key});

  @override
  State<FlowSignUpScreen> createState() => _FlowSignUpScreenState();
}

class _FlowSignUpScreenState extends State<FlowSignUpScreen> {
  int genders = 2;
  int age = 8;
  final List<Map> _goals = [];
  Map<int, bool> selectedFlag = {};
  int choice = 5;
  Map<String, dynamic> profileData = {
    'name': '',
    'phoneNumber': '',
    'dateOfBirth': ''
  };

  PageController pageController =
      PageController(initialPage: 0, keepPage: false);
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  int _cunrruntPage = 0;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phoneNumber.dispose();
    password.dispose();
    rePassword.dispose();
    dateOfBirth.dispose();
    pageController.dispose();
    super.dispose();
  }

  void setGender(int val) {
    genders = val;
  }

  void setAge(int val) {
    age = val;
  }

  void setGoal(Map<int, bool> data) {
    selectedFlag = data;
  }

  setChoice(int val) {
    choice = val;
  }

  void _showSnackBar(String title, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AuthController>(context);
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
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                // onPageChanged: (value) {
                //   setState(() {
                //     _cunrruntPage = value;
                //   });
                // },
                children: [
                  GenderSlide(
                    genders: genders,
                    setGender: setGender,
                  ),
                  AgeSlide(
                    age: age,
                    setAge: setAge,
                  ),
                  GoalSlide(
                    setGoal: setGoal,
                    selectedFlag: selectedFlag,
                  ),
                  TimeSlide(
                    setChoice: setChoice,
                    choice: choice,
                  ),
                  ProfileSlide(
                    dateOfBirth: dateOfBirth,
                    name: name,
                    phoneNumber: phoneNumber,
                  ),
                  SignUpSlide(
                    email: email,
                    password: password,
                    rePassword: rePassword,
                  ),
                ],
              ),
            ),
            InkWell(
              child: data.isLoading
                  ? Container()
                  : AuthButton(
                      backGroundColor: Theme.of(context).colorScheme.primary,
                      title: _cunrruntPage == 5 ? 'Sign up' : 'Continue',
                      color: Colors.white),
              onTap: () async {
                switch (_cunrruntPage) {
                  case 0:
                    if (genders == 2) {
                      _showSnackBar('Please choose your gender!', context);
                      return;
                    }
                    break;
                  case 1:
                    if (age == 8) {
                      _showSnackBar('Please choose your age!', context);
                      return;
                    }
                    break;
                  case 2:
                    selectedFlag.forEach((key, value) {
                      if (value == true) {
                        _goals.add(goalDatas[key]);
                      }
                    });

                    break;
                  case 3:
                    if (choice == 5) {
                      _showSnackBar('Please choose your answer!', context);
                      return;
                    }
                    break;
                  case 4:
                    if (name.text == '' ||
                        dateOfBirth.text == '' ||
                        phoneNumber.text == '') {
                      _showSnackBar('Please enter all the fields', context);
                      return;
                    }
                    if (name.text.length < 6) {
                      _showSnackBar(
                          'Name must have at least 6 characters', context);
                      return;
                    }
                    if (phoneNumber.text.length < 8) {
                      _showSnackBar(
                          'Phone number must have at least 8 characters',
                          context);
                      return;
                    }
                    break;
                  case 5:
                    if (email.text == '' ||
                        password.text == '' ||
                        rePassword.text == '') {
                      _showSnackBar('Please enter all the fields', context);
                      return;
                    }
                    if (!email.text.contains('@')) {
                      _showSnackBar('Invalid email', context);

                      return;
                    }
                    if (rePassword.text != password.text) {
                      _showSnackBar('Passwords do not match!', context);
                    }
                    if (password.text.length < 6) {
                      _showSnackBar(
                          'Password must have at least 6 characters', context);
                      return;
                    }
                    // print({
                    //   'gender': gendersDatas[genders],
                    //   'age': ageDatas[age],
                    //   'goals': _goals,
                    //   'choice': goalDatas[choice],
                    //   'name': name.text,
                    //   'dateOfBirth': dateOfBirth.text,
                    //   'phoneNumber': phoneNumber.text,
                    //   'auth': {'email': email.text, 'password': password.text}
                    // });
                    await Provider.of<AuthController>(context)
                        .signUp(email.text, password.text, {
                      'gender': gendersDatas[genders],
                      'age': ageDatas[age],
                      'goals': _goals,
                      'choice': goalDatas[choice],
                      'name': name.text,
                      'dateOfBirth': dateOfBirth.text,
                      'phoneNumber': phoneNumber.text,
                      'auth': {'email': email.text, 'password': password.text}
                    });
                    break;
                  default:
                }
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
