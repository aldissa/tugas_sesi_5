/// Model data satu seminar / workshop.
class EventItem {
  final String id;
  final String title;
  final String category; // AI, Mobile, IoT, Cybersecurity
  final DateTime date;
  final String location;
  final int price; // 0 = gratis

  const EventItem({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.price,
  });

  bool get isFree => price == 0;

  /// Contoh: "Sabtu, 14 Nov 2026"
  String get formattedDate {
    const days = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${days[date.weekday - 1]}, ${date.day} '
        '${months[date.month - 1]} ${date.year}';
  }

  /// Contoh: "Rp 35.000" atau "Gratis"
  String get formattedPrice => isFree ? 'Gratis' : _formatRupiah(price);

  static String _formatRupiah(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return 'Rp $buffer';
  }
}