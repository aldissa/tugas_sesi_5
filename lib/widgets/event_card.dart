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
      // Supaya ripple InkWell mengikuti sudut kartu yang membulat.
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  categoryIcon(event.category),
                  size: 36,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 12),
              // Expanded mencegah teks panjang menyebabkan overflow.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colors.secondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        event.category,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
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
                      text: event.formattedDate,
                    ),
                    const SizedBox(height: 2),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      text: event.location,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.formattedPrice,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: event.isFree
                            ? Colors.green.shade700
                            : colors.primary,
                      ),
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