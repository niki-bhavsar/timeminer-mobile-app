import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer, // full screen red
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,  // match AppBar with background
        centerTitle: true,
        title: const Text('Hello World App'),
      ),
      body: const Center(
        child: Text(
          'Hello World!',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white, // visible on red background
          ),
        ),
      ),
    );
  }
}
