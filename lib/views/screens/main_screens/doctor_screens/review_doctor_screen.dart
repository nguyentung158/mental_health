// ignore_for_file: library_private_types_in_public_api

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/doctor_controller.dart';
import 'package:mental_health_app/views/widgets/auth_button.dart';
import 'package:provider/provider.dart';

class ReviewDoctorScreen extends StatefulWidget {
  final String docId;

  const ReviewDoctorScreen({super.key, required this.docId});
  @override
  _ReviewDoctorScreenState createState() => _ReviewDoctorScreenState();
}

class _ReviewDoctorScreenState extends State<ReviewDoctorScreen> {
  double rating = 0;
  String reviewChoice = 'good';
  double satisfactionScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Doctor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Rate the doctor:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            RatingBar(
              onRatingChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose review:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceButton(
                  text: 'Good',
                  isSelected: reviewChoice == 'good',
                  onTap: () {
                    setState(() {
                      reviewChoice = 'good';
                    });
                  },
                ),
                const SizedBox(width: 10),
                ChoiceButton(
                  text: 'Bad',
                  isSelected: reviewChoice == 'bad',
                  onTap: () {
                    setState(() {
                      reviewChoice = 'bad';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Satisfaction Score: ${satisfactionScore.toInt()}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: satisfactionScore,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  satisfactionScore = value;
                });
              },
              divisions: 10,
              label: satisfactionScore.toInt().toString(),
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            InkWell(
                onTap: () async {
                  await Provider.of<DoctorController>(context, listen: false)
                      .voteDoctor(widget.docId, {
                    'Review': reviewChoice,
                    'Rating': rating,
                    'Satisfaction score': satisfactionScore
                  });
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.bottomSlide,
                          title: 'Congratulation!',
                          desc: 'You have successfully evaluated the doctor.',
                          dismissOnTouchOutside: false,
                          btnOkOnPress: (() async {
                            Navigator.of(context).pop();
                          }),
                          dismissOnBackKeyPress: false)
                      .show();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: AuthButton(
                      title: 'Submiit',
                      color: Colors.white,
                      backGroundColor: Theme.of(context).colorScheme.primary),
                )),
          ],
        ),
      ),
    );
  }
}

class RatingBar extends StatefulWidget {
  final int maxRating;
  final double initialRating;
  final ValueChanged<double>? onRatingChanged;

  const RatingBar({
    super.key,
    this.maxRating = 5,
    this.initialRating = 0,
    this.onRatingChanged,
  });

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double _currentRating = 0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.maxRating,
        (index) {
          IconData starIcon =
              index < _currentRating ? Icons.star : Icons.star_border;
          Color starColor =
              index < _currentRating ? Colors.yellow : Colors.grey;

          return GestureDetector(
            onTap: () {
              setState(() {
                _currentRating = index + 1.toDouble();
                widget.onRatingChanged?.call(_currentRating);
              });
            },
            child: Icon(
              starIcon,
              color: starColor,
            ),
          );
        },
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiceButton(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
