import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  bool obscureText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.textInputType,
      required this.textEditingController});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _showIcon = false;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    if (!_isLoaded) {
      _showIcon = widget.obscureText;
    }
    _isLoaded = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.textEditingController,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: _showIcon == true
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    icon: Icon(
                      widget.obscureText == true
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : null));
  }
}
