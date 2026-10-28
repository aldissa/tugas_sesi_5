import 'package:flutter/material.dart';

import '../models/event_item.dart';

/// Ikon pengganti poster, dipilih berdasarkan kategori.
IconData categoryIcon(String category) {
  switch (category) {
    case 'AI':
      return Icons.psychology;
    case 'Mobile':
      return Icons.smartphone;
    case 'IoT':
      return Icons.memory;
    case 'Cybersecurity':
      return Icons.security;
    default:
      return Icons.event;
  }
}

/// Kartu seminar yang bisa ditekan (InkWell).
class EventCard extends StatelessWidget {
  final EventItem event;
  final VoidCallback onTap;

  const EventCard({super.key, required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      // Supaya efek ripple InkWell mengikuti sudut kartu yang membulat.
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail sederhana: kotak berwarna + ikon kategori.
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  categoryIcon(event.category),
                  size: 40,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 12),
              // Expanded mencegah teks panjang menyebabkan overflow.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge kategori emas.
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6EEDC),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        event.category.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF795902),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      event.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      text: '${event.formattedDate} • ${event.time}',
                    ),
                    const SizedBox(height: 2),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      text: event.location,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          event.formattedPrice,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: event.isFree
                                ? Colors.green.shade700
                                : colors.primary,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Sisa ${event.quota} kuota',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: event.quota <= 10
                                  ? Colors.orange.shade800
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Baris kecil: ikon + teks (tanggal, lokasi).
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }
}