import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/event_item.dart';
import '../models/registration_ticket.dart';

class EventRegistrationScreen extends StatefulWidget {
  final EventItem event;

  const EventRegistrationScreen({super.key, required this.event});

  @override
  State<EventRegistrationScreen> createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  // GlobalKey dipakai untuk memvalidasi seluruh field di dalam Form.
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _dateController = TextEditingController();

  static const List<String> _kitOptions = [
    'Tanpa Kit',
    'Basic Kit',
    'Premium Kit',
  ];

  String _participantType = 'Mahasiswa';
  String _kitPackage = 'Tanpa Kit';
  DateTime? _attendanceDate;
  bool _donation = false;
  bool _agreed = false;
  bool _showAgreeError = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // ---------- Validator ----------
  String? _validateName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Nama lengkap wajib diisi';
    if (text.length < 3) return 'Nama minimal 3 karakter';
    return null;
  }

  String? _validateNim(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'NIM wajib diisi';
    if (!RegExp(r'^\d{8,12}$').hasMatch(text)) {
      return 'NIM harus berupa 8-12 digit angka';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Email wajib diisi';
    if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(text)) {
      return 'Email tidak valid';
    }
    return null;
  }

  String? _validateWhatsapp(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Nomor WhatsApp wajib diisi';
    if (!RegExp(r'^(08|62)\d{8,12}$').hasMatch(text)) {
      return 'Gunakan awalan 08 atau 62 (10-14 digit)';
    }
    return null;
  }

  String? _validateDate(String? value) {
    if (_attendanceDate == null) return 'Tanggal kehadiran wajib dipilih';
    return null;
  }

  // ---------- Date picker ----------
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    // initialDate tidak boleh sebelum firstDate, jadi dibatasi ke hari ini.
    final initial = widget.event.date.isBefore(today) ? today : widget.event.date;

    final picked = await showDatePicker(
      context: context,
      initialDate: _attendanceDate ?? initial,
      firstDate: today,
      lastDate: DateTime(today.year + 2),
    );

    if (picked != null) {
      setState(() {
        _attendanceDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  String _formatDate(DateTime d) {
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    return '$day/$month/${d.year}';
  }

  // ---------- Submit ----------
  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();
    // Checkbox bukan FormField, jadi dicek manual.
    setState(() => _showAgreeError = !_agreed);
    if (!isValid || !_agreed) return;

    setState(() => _isSubmitting = true);
    // Simulasi proses kirim data ke server.
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final ticket = RegistrationTicket(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      event: widget.event,
      name: _nameController.text.trim(),
      nim: _nimController.text.trim(),
      email: _emailController.text.trim(),
      whatsapp: _whatsappController.text.trim(),
      participantType: _participantType,
      attendanceDate: _attendanceDate!,
      kitPackage: _kitPackage,
      donation: _donation,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pendaftaran berhasil! Tiket sudah tersimpan.')),
    );
    Navigator.pop(context, ticket); // kirim tiket ke layar sebelumnya
  }

  InputDecoration _decoration(String label, {IconData? icon, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pendaftaran Tiket',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      // SingleChildScrollView mencegah overflow saat keyboard muncul.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ringkasan acara.
              Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: Icon(Icons.event, color: colors.primary),
                  title: Text(
                    event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text('${event.formattedDate} • ${event.formattedPrice}'),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: _decoration('Nama Lengkap', icon: Icons.person_outline),
                validator: _validateName,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                decoration: _decoration('NIM', icon: Icons.badge_outlined),
                validator: _validateNim,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: _decoration('Email', icon: Icons.email_outlined),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _whatsappController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
                decoration: _decoration(
                  'Nomor WhatsApp',
                  icon: Icons.phone_outlined,
                  hint: '08xxxxxxxxxx',
                ),
                validator: _validateWhatsapp,
              ),
              const SizedBox(height: 20),

              const Text(
                'Tipe Peserta',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(value: 'Mahasiswa', label: Text('Mahasiswa')),
                    ButtonSegment(value: 'Umum', label: Text('Umum')),
                    ButtonSegment(value: 'Dosen', label: Text('Dosen')),
                  ],
                  selected: {_participantType},
                  onSelectionChanged: (selection) {
                    setState(() => _participantType = selection.first);
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Field tanggal hanya bisa diisi lewat date picker.
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: _pickDate,
                decoration: _decoration(
                  'Tanggal Kehadiran',
                  icon: Icons.calendar_today_outlined,
                ),
                validator: _validateDate,
              ),
              const SizedBox(height: 20),

              const Text(
                'Paket Seminar Kit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              // Wrap otomatis turun baris di layar sempit (anti overflow).
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _kitOptions.map((kit) {
                  return ChoiceChip(
                    label: Text(kit),
                    selected: _kitPackage == kit,
                    onSelected: (_) => setState(() => _kitPackage = kit),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              Card(
                margin: EdgeInsets.zero,
                child: SwitchListTile(
                  title: const Text('Donasi'),
                  subtitle: const Text('Dukung kegiatan seminar kampus'),
                  value: _donation,
                  onChanged: (value) => setState(() => _donation = value),
                ),
              ),
              const SizedBox(height: 12),

              Card(
                margin: EdgeInsets.zero,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('Saya menyetujui tata tertib acara'),
                  value: _agreed,
                  onChanged: (value) {
                    setState(() {
                      _agreed = value ?? false;
                      if (_agreed) _showAgreeError = false;
                    });
                  },
                ),
              ),
              if (_showAgreeError)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 6),
                  child: Text(
                    'Anda harus menyetujui tata tertib',
                    style: TextStyle(color: colors.error, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  // Dinonaktifkan saat loading agar tidak terkirim dua kali.
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Daftar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}