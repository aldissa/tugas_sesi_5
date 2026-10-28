import '../models/event_item.dart';

/// Kategori filter sesuai tugas.
const List<String> eventCategories = ['AI', 'Mobile', 'IoT', 'Cybersecurity'];

/// Data contoh seminar (tanpa database).
final List<EventItem> sampleEvents = [
  EventItem(
    id: 'ev-001',
    title: 'Simposium Nasional Generative AI & Etika Akademik',
    category: 'AI',
    date: DateTime(2026, 11, 14),
    location: 'Auditorium Gd. Rektorat Lt. 3',
    price: 0,
  ),
  EventItem(
    id: 'ev-002',
    title: 'Hands-on Workshop: Clean Architecture Flutter 3',
    category: 'Mobile',
    date: DateTime(2026, 11, 15),
    location: 'Lab Komputer 2',
    price: 35000,
  ),
  EventItem(
    id: 'ev-003',
    title: 'Inovasi Smart Campus Berbasis LoRaWAN & ESP32',
    category: 'IoT',
    date: DateTime(2026, 11, 18),
    location: 'Ruang Seminar 1, Gedung Riset',
    price: 0,
  ),
  EventItem(
    id: 'ev-004',
    title: 'Cyber Defense: Mengamankan Aplikasi Web dan Mobile',
    category: 'Cybersecurity',
    date: DateTime(2026, 11, 21),
    location: 'Nusaputra University, Lab Komputer 3',
    price: 50000,
  ),
  EventItem(
    id: 'ev-005',
    title: 'Workshop Machine Learning untuk Pemula',
    category: 'AI',
    date: DateTime(2026, 11, 25),
    location: 'Lab Komputer B-101, Fasilkom',
    price: 25000,
  ),
  EventItem(
    id: 'ev-006',
    title: 'Pengembangan Aplikasi Android dengan Kotlin dan Compose',
    category: 'Mobile',
    date: DateTime(2026, 11, 28),
    location: 'Ruang Seminar 2, Gedung Riset',
    price: 0,
  ),
];