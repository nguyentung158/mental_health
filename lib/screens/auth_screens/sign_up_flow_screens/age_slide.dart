import 'package:flutter/material.dart';

class AgeSlide extends StatefulWidget {
  int age;
  final Function setAge;
  AgeSlide({super.key, required this.age, required this.setAge});

  @override
  State<AgeSlide> createState() => _AgeSlideState();
}

class _AgeSlideState extends State<AgeSlide> {
  Widget _buildAgeButton(String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.age = index;
        });
        widget.setAge(index);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 0),
        color: widget.age == index
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: widget.age == index
                ? Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white)
                : Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.age);
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Age',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Select your age range ',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3.5,
              mainAxisSpacing: 20,
              crossAxisSpacing: 12,
              children: [
                _buildAgeButton('14 - 17', 0),
                _buildAgeButton('18 - 24', 1),
                _buildAgeButton('25 - 29', 2),
                _buildAgeButton('30 - 34', 3),
                _buildAgeButton('35 - 39', 4),
                _buildAgeButton('40 - 44', 5),
                _buildAgeButton('45 - 49', 6),
                _buildAgeButton('≥ 50', 7),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
