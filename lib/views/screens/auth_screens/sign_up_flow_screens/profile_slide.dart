import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/auth_controller.dart';
import 'package:mental_health_app/views/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

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
            Consumer<AuthController>(
              builder: (context, value, child) => Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: value.pickedImage == null
                          ? Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJyse3siLx1MO5Pl0NHo9yQCL1vuGbG96ZYebSR2Ld5w&s',
                              fit: BoxFit.cover,
                            ).image
                          : Image.file(
                              value.pickedImage!,
                              fit: BoxFit.cover,
                            ).image,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: InkWell(
                        child: const Icon(Icons.camera_alt_outlined),
                        onTap: () => value.pickImage(),
                      ),
                    ),
                  ],
                ),
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
            TextField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    dateOfBirth.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
                },
                controller: dateOfBirth,
                decoration: const InputDecoration(
                    labelText: 'Select date',
                    suffixIcon: Icon(Icons.calendar_today_rounded))),
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
