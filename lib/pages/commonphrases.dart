import 'package:flutter/material.dart';

class Commonphrases extends StatelessWidget {
  const Commonphrases({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn common phrases'),
        backgroundColor: const Color.fromARGB(255, 43, 255, 0),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Common phrases unit!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}