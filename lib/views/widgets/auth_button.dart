import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class AuthButton extends StatefulWidget {
  final String title;
  final Color color;
  final Color backGroundColor;
  const AuthButton(
      {super.key,
      required this.title,
      required this.color,
      required this.backGroundColor});

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        elevation: 5,
        color: widget.backGroundColor,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 12,
          child: Consumer<AuthController>(builder: (context, value, child) {
            return Center(
              child: value.isLoading
                  ? CircularProgressIndicator(
                      color: widget.color,
                    )
                  : Text(
                      widget.title,
                      style: TextStyle(
                          color: widget.color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
            );
          }),
        ));
  }
}
