import 'package:flutter/material.dart';
import 'package:mental_health_app/constant.dart';

class GoalSlide extends StatefulWidget {
  final Map<int, bool> selectedFlag;
  final Function setGoal;
  const GoalSlide(
      {super.key, required this.selectedFlag, required this.setGoal});

  @override
  State<GoalSlide> createState() => _GoalSlideState();
}

class _GoalSlideState extends State<GoalSlide> {
  Map<int, bool> selectedFlag = {};

  Widget _buildSelectIcon(bool isSelected, Map data) {
    return Icon(
      isSelected ? Icons.check_box : Icons.check_box_outline_blank,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedFlag = widget.selectedFlag;
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is Your Goal by Doing Meditation?',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Select the goals you want to achieve with meditation to get better program recommendations',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: goalDatas.length,
                  itemBuilder: ((context, index) {
                    selectedFlag[index] = selectedFlag[index] ?? false;
                    bool isSelected = selectedFlag[index]!;
                    return ListTile(
                      onTap: () => onTap(isSelected, index),
                      title: Text(goalDatas[index]['title']),
                      leading: _buildSelectIcon(isSelected, goalDatas[index]),
                    );
                  })))
        ],
      ),
    );
  }
}
