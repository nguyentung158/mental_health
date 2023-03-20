import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String route = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseAuth.instance.signOut(),
      ),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.amber),
            height: 200,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            height: 200,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            height: 200,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.red),
            height: 200,
          ),
        ],
      ),
    );
  }
}
