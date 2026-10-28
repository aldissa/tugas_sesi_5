import 'package:flutter/material.dart';

import '../models/registration_ticket.dart';

class RegisteredTicketsScreen extends StatelessWidget {
  final List<RegistrationTicket> tickets;
  final void Function(RegistrationTicket ticket) onCancel;

  const RegisteredTicketsScreen({
    super.key,
    required this.tickets,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    // Sementara: diisi lengkap di Langkah 7.
    return Center(child: Text('${tickets.length} tiket aktif'));
  }
}