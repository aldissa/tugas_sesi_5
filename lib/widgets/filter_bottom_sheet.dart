import 'package:flutter/material.dart';

import '../data/sample_events.dart';

/// Membuka bottom sheet filter.
/// Hasil: nama kategori, '' (artinya tanpa filter), atau null (ditutup).
Future<String?> showFilterBottomSheet(
  BuildContext context, {
  required String? selected,
}) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => _FilterSheet(initial: selected),
  );
}

class _FilterSheet extends StatefulWidget {
  final String? initial;

  const _FilterSheet({required this.initial});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Kategori',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            // Wrap otomatis turun baris jika layar sempit (anti overflow).
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: eventCategories.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: _selected == category,
                  onSelected: (isSelected) {
                    setState(() => _selected = isSelected ? category : null);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context, _selected ?? ''),
                child: const Text('Terapkan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}