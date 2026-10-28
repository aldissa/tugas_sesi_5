import 'package:flutter/material.dart';

import 'screens/gallery_venue_screen.dart';
import 'screens/home_events_screen.dart';
import 'screens/registered_tickets_screen.dart';

// Warna utama diambil dari design system Stitch.
const Color kNavy = Color(0xFF0F1B3D);
const Color kGold = Color(0xFFC9A24B);
const Color kBackground = Color(0xFFF8F7F4);

void main() {
  runApp(const NusaEventApp());
}

class NusaEventApp extends StatelessWidget {
  const NusaEventApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: kNavy,
      primary: kNavy,
      secondary: kGold,
      surface: Colors.white,
    );

    return MaterialApp(
      title: 'NusaEvent Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: kBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackground,
          foregroundColor: kNavy,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Color(0xFFF6EEDC),
        ),
      ),
      home: const MainShell(),
    );
  }
}

/// Kerangka utama: menampung 3 tab dan NavigationBar di bawah.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // Daftar halaman sesuai urutan tab.
  final List<Widget> _pages = const [
    HomeEventsScreen(),
    GalleryVenueScreen(),
    RegisteredTicketsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack menjaga state tiap tab saat berpindah tab.
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon: Icon(Icons.event),
            label: 'Seminar',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_library_outlined),
            selectedIcon: Icon(Icons.photo_library),
            label: 'Galeri',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(Icons.confirmation_number),
            label: 'Tiket',
          ),
        ],
      ),
    );
  }
}