import 'event_item.dart';

/// Model tiket hasil pendaftaran peserta.
class RegistrationTicket {
  final String id;
  final String code; // kode masuk, contoh: NSE-2026-001
  final EventItem event;
  final String name;
  final String nim;
  final String email;
  final String whatsapp;
  final String participantType; // Mahasiswa / Umum / Dosen
  final DateTime attendanceDate;
  final String kitPackage; // Tanpa Kit / Basic Kit / Premium Kit
  final int donation;

  const RegistrationTicket({
    required this.id,
    required this.code,
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

  /// Harga paket kit.
  int get kitPrice {
    switch (kitPackage) {
      case 'Basic Kit':
        return 25000;
      case 'Premium Kit':
        return 50000;
      default:
        return 0;
    }
  }

  /// Total = harga tiket + kit + donasi.
  int get totalPrice => event.price + kitPrice + donation;
}