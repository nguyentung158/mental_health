import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  bool obscureText;
  final TextInputType textInputType;
  MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.textInputType});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: widget.textInputType,
        obscureText: !_visible,
        decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.obscureText == true
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    },
                    icon: Icon(
                      _visible == false
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : null));
  }
}
