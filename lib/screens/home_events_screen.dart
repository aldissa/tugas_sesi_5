import 'package:flutter/material.dart';

import '../data/sample_events.dart';

class HomeEventsScreen extends StatelessWidget {
  const HomeEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NusaEvent Hub')),
      body: Center(
        child: Text(
          '${sampleEvents.length} seminar\n'
          '${sampleEvents.first.formattedDate}\n'
          '${sampleEvents[1].formattedPrice}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}