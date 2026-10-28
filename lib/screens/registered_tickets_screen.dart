import 'package:flutter/material.dart';

class RegisteredTicketsScreen extends StatelessWidget {
  const RegisteredTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tiket Terdaftar')),
      body: const Center(child: Text('Tiket Terdaftar')),
    );
  }
}