import 'package:flutter/material.dart';

/// Denah venue yang bisa digeser dan diperbesar (InteractiveViewer).
class VenueMapViewer extends StatelessWidget {
  const VenueMapViewer({super.key});

  static const double _mapWidth = 360;
  static const double _mapHeight = 400;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: _mapWidth / _mapHeight,
        child: InteractiveViewer(
          minScale: 0.8,
          maxScale: 4.0,
          // FittedBox menyesuaikan denah dengan lebar layar (anti overflow).
          child: const FittedBox(
            child: SizedBox(
              width: _mapWidth,
              height: _mapHeight,
              child: _MapContent(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Isi denah: Stack + Positioned pada kanvas 360 x 400.
class _MapContent extends StatelessWidget {
  const _MapContent();

  static const Color _navy = Color(0xFF0F1B3D);
  static const Color _gold = Color(0xFFFDD275);
  static const Color _blue = Color(0xFFDDE3F8);
  static const Color _grey = Color(0xFFE7E5E0);
  static const Color _red = Color(0xFFFFDAD6);

  Widget _zone({
    required double left,
    required double top,
    required double width,
    required double height,
    required String label,
    required Color color,
    Color textColor = Colors.black87,
    int quarterTurns = 0,
  }) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: RotatedBox(
          quarterTurns: quarterTurns,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          _zone(left: 60, top: 12, width: 240, height: 48,
              label: 'PANGGUNG UTAMA', color: _navy, textColor: Colors.white),
          _zone(left: 8, top: 20, width: 44, height: 28,
              label: 'EXIT', color: _red, textColor: Colors.red.shade800),
          _zone(left: 308, top: 20, width: 44, height: 28,
              label: 'EXIT', color: _red, textColor: Colors.red.shade800),
          _zone(left: 40, top: 72, width: 280, height: 40,
              label: 'KURSI VIP & SPEAKER', color: _gold),
          _zone(left: 8, top: 124, width: 44, height: 170,
              label: 'LAB WORKSHOP A', color: _blue, quarterTurns: 3),
          _zone(left: 308, top: 124, width: 44, height: 170,
              label: 'LAB WORKSHOP B', color: _blue, quarterTurns: 1),
          _zone(left: 64, top: 124, width: 112, height: 140,
              label: 'PESERTA A', color: _grey),
          _zone(left: 184, top: 124, width: 112, height: 140,
              label: 'PESERTA B', color: _grey),
          _zone(left: 64, top: 276, width: 232, height: 52,
              label: 'MEJA REGISTRASI & SCAN QR',
              color: _navy, textColor: Colors.white),
          _zone(left: 8, top: 310, width: 44, height: 40,
              label: 'WC', color: _grey),
          _zone(left: 308, top: 310, width: 44, height: 40,
              label: 'SHOLAT', color: _grey),
          _zone(left: 64, top: 346, width: 232, height: 32,
              label: '↑ PINTU MASUK UTAMA ↑', color: const Color(0xFFF6EEDC)),
        ],
      ),
    );
  }
}