import 'package:flutter/material.dart';

class HomeEventsScreen extends StatelessWidget {
  const HomeEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NusaEvent Hub')),
      body: const Center(child: Text('Seminar & Workshop')),
    );
  }
}