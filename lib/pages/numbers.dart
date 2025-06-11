import 'package:flutter/material.dart';

class Numbers extends StatelessWidget {
  const Numbers({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Numbers'),
        backgroundColor: const Color.fromARGB(255, 43, 255, 0),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Numbers Unit!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}