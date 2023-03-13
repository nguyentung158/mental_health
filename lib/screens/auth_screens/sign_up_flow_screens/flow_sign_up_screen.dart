import 'package:flutter/material.dart';

class FlowSignUpScreen extends StatelessWidget {
  static String route = '/sign0';
  const FlowSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: PageView(
        children: [
          Card(
            color: Colors.yellow,
            child: Column(children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ]),
          ),
          Card(
            color: Colors.yellow,
            child: Column(children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ]),
          ),
          Card(
            color: Colors.yellow,
            child: Column(children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
