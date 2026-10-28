import 'event_item.dart';

/// Model tiket hasil pendaftaran peserta.
class RegistrationTicket {
  final String id;
  final EventItem event;
  final String name;
  final String nim;
  final String email;
  final String whatsapp;
  final String participantType; // Mahasiswa / Umum / Dosen
  final DateTime attendanceDate;
  final String kitPackage; // Tanpa Kit / Basic Kit / Premium Kit
  final bool donation;

  const RegistrationTicket({
    required this.id,
    required this.event,
    required this.name,
    required this.nim,
    required this.email,
    required this.whatsapp,
    required this.participantType,
    required this.attendanceDate,
    required this.kitPackage,
    required this.donation,
  });
}