import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/account_controller.dart';
import 'package:mental_health_app/controllers/auth_controller.dart';
import 'package:mental_health_app/models/user.dart';
import 'package:mental_health_app/views/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

enum FieldName { name, email }

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key, required this.user});
  final User user;
  bool isEditing = false;
  File? pickedimg;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text = user.name;
    phoneNumber.text = user.phoneNumber;
    email.text = user.email;
    dateOfBirth.text = user.dateOfBirth;
    var data = Provider.of<AccountController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Personal info',
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: IconButton(
          onPressed: (() {
            Navigator.of(context).pop();
          }),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          Consumer<AccountController>(
            builder: (context, value, child) => value.isLoading == false
                ? IconButton(
                    onPressed: (() async {
                      await data.editProfile(name.text, email.text,
                          phoneNumber.text, dateOfBirth.text);
                      Navigator.of(context).pop();
                    }),
                    icon: Icon(
                      Icons.done,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Consumer<AccountController>(
                      builder: (context, value, child) => Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: pickedimg == null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      user.profilePhoto,
                                    ))
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(pickedimg!))),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            pickedimg = await data.pickImage();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField('Full name', name),
              const SizedBox(
                height: 15,
              ),
              buildTextField('Email', email),
              const SizedBox(
                height: 15,
              ),
              buildTextField('Phone Number', phoneNumber),
              const SizedBox(
                height: 15,
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
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String title, TextEditingController controller) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          MyTextField(
              hintText: '',
              obscureText: false,
              textInputType: TextInputType.name,
              textEditingController: controller),
        ],
      ),
    );
  }
}
