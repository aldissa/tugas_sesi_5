import 'package:flutter/material.dart';

import '../data/sample_events.dart';
import '../models/event_item.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';

class HomeEventsScreen extends StatefulWidget {
  const HomeEventsScreen({super.key});

  @override
  State<HomeEventsScreen> createState() => _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  String _selectedCategory = 'Semua';

  // Daftar yang tampil, dihitung dari kategori terpilih.
  List<EventItem> get _filteredEvents {
    if (_selectedCategory == 'Semua') return sampleEvents;
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
      setState(() => _selectedCategory = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = _filteredEvents;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NusaEvent Hub',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Filter',
            onPressed: _openFilterSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Baris chip kategori yang bisa digeser horizontal.
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: eventCategories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: _selectedCategory == category
                          ? Colors.white
                          : null,
                    ),
                    onSelected: (_) {
                      setState(() => _selectedCategory = category);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Seminar & Workshop',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${events.length} tersedia',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          // Expanded memberi ListView tinggi sisa layar (anti overflow).
          Expanded(
            child: events.isEmpty
                ? const Center(child: Text('Belum ada seminar di kategori ini'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
      ),
    );
  }
}