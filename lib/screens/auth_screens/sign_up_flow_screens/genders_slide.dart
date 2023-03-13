import 'package:flutter/material.dart';

class GenderSlide extends StatefulWidget {
  int genders;
  Function setGender;
  GenderSlide({super.key, required this.genders, required this.setGender});

  @override
  State<GenderSlide> createState() => _GenderSlideState();
}

class _GenderSlideState extends State<GenderSlide> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is your gender?',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Select your gender',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'I am male',
                style: Theme.of(context).textTheme.headline6,
              ),
              leading: Radio(
                  value: 1,
                  groupValue: widget.genders,
                  onChanged: (val) {
                    setState(() {
                      widget.genders = 1;
                    });
                    widget.setGender(1);
                  })),
          ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'I am female',
                style: Theme.of(context).textTheme.headline6,
              ),
              leading: Radio(
                  value: 0,
                  groupValue: widget.genders,
                  onChanged: (val) {
                    setState(() {
                      widget.genders = 0;
                    });
                    widget.setGender(0);
                  })),
        ],
      ),
    );
  }
}
