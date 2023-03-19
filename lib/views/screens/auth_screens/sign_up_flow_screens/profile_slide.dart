import 'package:flutter/material.dart';
import 'package:mental_health_app/views/widgets/text_field.dart';

class ProfileSlide extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController phoneNumber;
  final TextEditingController dateOfBirth;
  const ProfileSlide(
      {super.key,
      required this.name,
      required this.phoneNumber,
      required this.dateOfBirth});

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
              'Complete your profile',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Don't worry, only you can see your personal data. No one else will be able to see it.",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Image.network(
                      'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs2/117796916/original/cc9999c311fc59802ffb7be4c6ca872582ff79a3/draw-a-cute-and-nice-avatar-or-portrait-for-you.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 5,
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: deviceSize.height / 40,
              width: double.infinity,
            ),
            Text(
              'Full name',
              style: Theme.of(context).textTheme.headline6,
            ),
            MyTextField(
              textEditingController: name,
              hintText: 'Enter your full name',
              obscureText: false,
              textInputType: TextInputType.name,
            ),
            SizedBox(
              height: deviceSize.height / 40,
              width: double.infinity,
            ),
            Text(
              'Phone number',
              style: Theme.of(context).textTheme.headline6,
            ),
            MyTextField(
              textEditingController: phoneNumber,
              hintText: 'Enter your phone number',
              obscureText: false,
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: deviceSize.height / 40,
              width: double.infinity,
            ),
            Text(
              'Date of birth',
              style: Theme.of(context).textTheme.headline6,
            ),
            MyTextField(
              textEditingController: dateOfBirth,
              hintText: 'Enter your date of birth',
              obscureText: false,
              textInputType: TextInputType.datetime,
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
