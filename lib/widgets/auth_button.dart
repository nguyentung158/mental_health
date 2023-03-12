import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final Color color;
  const AuthButton({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      elevation: 10,
      color: color == Theme.of(context).colorScheme.primary
          ? Colors.white
          : Theme.of(context).colorScheme.primary,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 12,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
