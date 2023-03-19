import 'package:flutter/material.dart';
import 'package:mental_health_app/constant.dart';

class TimeSlide extends StatefulWidget {
  int choice;
  Function setChoice;
  TimeSlide({super.key, required this.choice, required this.setChoice});

  @override
  State<TimeSlide> createState() => _TimeSlideState();
}

class _TimeSlideState extends State<TimeSlide> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How Long Do You Want to Spend in Meditation?',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Find a more accurate meditation program by specifying the length of time to meditate.',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      timedatas[index]['title'],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: Radio(
                        value: index,
                        groupValue: widget.choice,
                        onChanged: (val) {
                          setState(() {
                            widget.choice = index;
                            widget.setChoice(index);
                          });
                        }));
              }),
              itemCount: timedatas.length,
            ),
          )
        ],
      ),
    );
  }
}
