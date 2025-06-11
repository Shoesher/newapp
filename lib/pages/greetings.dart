import 'package:flutter/material.dart';

class Greetings extends StatelessWidget {
  const Greetings({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Greetings'),
        backgroundColor: const Color.fromARGB(255, 43, 255, 0),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Greetings Unit!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}