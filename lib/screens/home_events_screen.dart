import 'package:flutter/material.dart';

import '../data/sample_events.dart';
import '../models/event_item.dart';
import '../models/registration_ticket.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/venue_map_viewer.dart';
import 'registered_tickets_screen.dart';

/// Layar utama: menampung 3 tab (Seminar, Galeri & Denah, Tiket).
class HomeEventsScreen extends StatefulWidget {
  const HomeEventsScreen({super.key});

  @override
  State<HomeEventsScreen> createState() => _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  static const List<String> _titles = [
    'NusaEvent Hub',
    'Galeri & Denah Venue',
    'Tiket Terdaftar',
  ];

  int _currentIndex = 0;
  String? _selectedCategory; // null = tampilkan semua
  final List<RegistrationTicket> _tickets = [];

  List<EventItem> get _filteredEvents {
    if (_selectedCategory == null) return sampleEvents;
    return sampleEvents
        .where((event) => event.category == _selectedCategory)
        .toList();
  }

  Future<void> _openFilterSheet() async {
    final result = await showFilterBottomSheet(
      context,
      selected: _selectedCategory,
    );
    if (result != null) {
      setState(() => _selectedCategory = result.isEmpty ? null : result);
    }
  }

  void _cancelTicket(RegistrationTicket ticket) {
    setState(() => _tickets.remove(ticket));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.tune),
              tooltip: 'Filter',
              onPressed: _openFilterSheet,
            ),
        ],
      ),
      // IndexedStack menjaga state tiap tab saat berpindah tab.
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildEventsTab(),
          _buildGalleryTab(),
          RegisteredTicketsScreen(tickets: _tickets, onCancel: _cancelTicket),
        ],
      ),
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

  // ---------- Tab 1: Seminar & Workshop ----------
  Widget _buildEventsTab() {
    final events = _filteredEvents;

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: eventCategories.map((category) {
              final isSelected = _selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : null),
                  // Tekan chip aktif lagi = batal pilih (tampilkan semua).
                  onSelected: (value) {
                    setState(() => _selectedCategory = value ? category : null);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        // Expanded memberi ListView tinggi sisa layar (anti overflow).
        Expanded(
          child: events.isEmpty
              ? const Center(child: Text('Belum ada seminar di kategori ini'))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: EventCard(
                        event: event,
                        onTap: () {
                          // Sementara: formulir dibuat di Langkah 6.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Dipilih: ${event.title}')),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ---------- Tab 2: Galeri & Denah Venue ----------
  Widget _buildGalleryTab() {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const Text(
          'Galeri Poster',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          // Grid di dalam ListView: tinggi mengikuti isi, scroll oleh ListView.
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sampleEvents.length,
          // Jumlah kolom menyesuaikan lebar layar (2 kolom di HP).
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final event = sampleEvents[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      color: colors.primary,
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              categoryIcon(event.category),
                              size: 48,
                              color: Colors.white70,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colors.secondary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                event.category,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  event.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Denah Venue',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        const VenueMapViewer(),
      ],
    );
  }
}