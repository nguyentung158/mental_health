import 'package:flutter/material.dart';

class MusicFilterButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  const MusicFilterButton(
      {super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      constraints: const BoxConstraints(minWidth: 90),
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height / 13,
          width: MediaQuery.of(context).size.height / 13,
          decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromRGBO(142, 151, 253, 1)
                  : const Color.fromRGBO(88, 104, 148, 1),
              borderRadius: BorderRadius.circular(20)),
          child: Image.asset(
            'assets/images/musics_icons/${title.toLowerCase()}.png',
            color: Colors.white,
            scale: 1 + 1 - 1 / 13,
          ),
        ),
        Expanded(
            child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.white, fontSize: 16),
          ),
        ))
      ]),
    );
  }
}
