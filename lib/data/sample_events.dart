import '../models/event_item.dart';

/// Daftar kategori untuk filter (urutan sama dengan chip di layar).
const List<String> eventCategories = [
  'Semua',
  'AI',
  'Mobile',
  'IoT',
  'Cybersecurity',
];

/// Data contoh seminar (tidak memakai database).
final List<EventItem> sampleEvents = [
  EventItem(
    id: 'ev-001',
    title: 'Simposium Nasional Generative AI & Etika Akademik',
    category: 'AI',
    speaker: 'Dr. Rina Kusuma, M.Kom.',
    description:
        'Membahas pemanfaatan generative AI di dunia akademik beserta '
        'etika penggunaannya.',
    date: DateTime(2026, 11, 14),
    time: '09:00 WIB',
    location: 'Auditorium Gd. Rektorat Lt. 3',
    price: 0,
    quota: 18,
  ),
  EventItem(
    id: 'ev-002',
    title: 'Hands-on Workshop: Clean Architecture Flutter 3',
    category: 'Mobile',
    speaker: 'Dimas Pratama, S.T.',
    description:
        'Praktik langsung membangun aplikasi Flutter dengan struktur '
        'folder yang rapi dan mudah dirawat.',
    date: DateTime(2026, 11, 15),
    time: '13:00 WIB',
    location: 'Lab Komputer C-204, Fasilkom',
    price: 35000,
    quota: 6,
  ),
  EventItem(
    id: 'ev-003',
    title: 'Inovasi Smart Campus Berbasis LoRaWAN & ESP32',
    category: 'IoT',
    speaker: 'Ir. Budi Santoso, M.T.',
    description:
        'Pengenalan jaringan LoRaWAN dan perangkat ESP32 untuk '
        'monitoring lingkungan kampus.',
    date: DateTime(2026, 11, 18),
    time: '10:00 WIB',
    location: 'Ruang Seminar 1, Gedung Riset',
    price: 0,
    quota: 32,
  ),
  EventItem(
    id: 'ev-004',
    title: 'Cyber Defense: Mengamankan Aplikasi Web dan Mobile',
    category: 'Cybersecurity',
    speaker: 'Sari Wulandari, CEH',
    description:
        'Teknik dasar mengenali dan menutup celah keamanan pada '
        'aplikasi web dan mobile.',
    date: DateTime(2026, 11, 21),
    time: '09:30 WIB',
    location: 'Aula Graha Widya Mandala',
    price: 50000,
    quota: 12,
  ),
  EventItem(
    id: 'ev-005',
    title: 'Workshop Machine Learning untuk Pemula',
    category: 'AI',
    speaker: 'Dr. Andi Wijaya, M.Sc.',
    description:
        'Membangun model klasifikasi sederhana dengan Python dari '
        'nol sampai evaluasi.',
    date: DateTime(2026, 11, 25),
    time: '13:00 WIB',
    location: 'Lab Komputer B-101, Fasilkom',
    price: 25000,
    quota: 20,
  ),
  EventItem(
    id: 'ev-006',
    title: 'Pengembangan Aplikasi Android dengan Kotlin dan Compose',
    category: 'Mobile',
    speaker: 'Rizky Fauzan, S.Kom.',
    description:
        'Pengantar Jetpack Compose untuk membuat UI Android modern.',
    date: DateTime(2026, 11, 28),
    time: '10:00 WIB',
    location: 'Ruang Seminar 2, Gedung Riset',
    price: 0,
    quota: 40,
  ),
];