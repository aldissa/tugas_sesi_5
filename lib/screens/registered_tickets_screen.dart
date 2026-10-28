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

  String _formatDate(DateTime d) {
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    return '$day/$month/${d.year}';
  }

  /// Dialog konfirmasi. Mengembalikan true jika pengguna memilih membatalkan.
  Future<bool> _confirmCancel(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batalkan tiket?'),
        content: const Text(
          'Apakah Anda yakin ingin membatalkan tiket pendaftaran ini?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Tidak'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya, Batalkan'),
          ),
        ],
      ),
    );
    // Jika dialog ditutup tanpa memilih (null), anggap tidak jadi batal.
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.confirmation_number_outlined,
                size: 56,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 12),
              const Text(
                'Belum ada tiket',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                'Daftar seminar di tab Seminar untuk mendapatkan tiket.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          // key unik wajib agar Dismissible menghapus item yang benar.
          child: Dismissible(
            key: ValueKey(ticket.id),
            // Hanya bisa digeser ke kiri.
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete_outline, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Batalkan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Dialog muncul dulu; item baru dihapus jika hasilnya true.
            confirmDismiss: (direction) => _confirmCancel(context),
            onDismissed: (direction) => onCancel(ticket),
            child: _TicketCard(
              ticket: ticket,
              attendanceDate: _formatDate(ticket.attendanceDate),
            ),
          ),
        );
      },
    );
  }
}

class _TicketCard extends StatelessWidget {
  final RegistrationTicket ticket;
  final String attendanceDate;

  const _TicketCard({required this.ticket, required this.attendanceDate});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _Tag(text: ticket.participantType, color: colors.secondary),
                _Tag(text: ticket.kitPackage, color: colors.primary),
                if (ticket.donation) _Tag(text: 'Donasi', color: Colors.green),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              ticket.event.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            _DetailRow(label: 'Nama', value: ticket.name),
            _DetailRow(label: 'NIM', value: ticket.nim),
            _DetailRow(label: 'Tanggal hadir', value: attendanceDate),
            _DetailRow(label: 'Lokasi', value: ticket.event.location),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final Color color;

  const _Tag({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
          ),
          // Expanded mencegah teks panjang menyebabkan overflow.
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}