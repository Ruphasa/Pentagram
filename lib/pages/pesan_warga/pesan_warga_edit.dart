import 'package:flutter/material.dart';
import '../../models/pesan_warga.dart';

class PesanWargaEditOverlay extends StatefulWidget {
  final PesanWarga pesan;
  const PesanWargaEditOverlay({super.key, required this.pesan});

  @override
  State<PesanWargaEditOverlay> createState() => _PesanWargaEditOverlayState();
}

class _PesanWargaEditOverlayState extends State<PesanWargaEditOverlay> {
  late String status;

  @override
  void initState() {
    super.initState();
    status = widget.pesan.status;
  }

  @override
  Widget build(BuildContext context) {
    const secondaryColor = Color(0xFF5a63b9);

    return GestureDetector(
      onTap: () => Navigator.pop(context), // Tutup saat tap di luar overlay
      behavior: HitTestBehavior.opaque,
      child: GestureDetector(
        onTap: () {}, // Supaya tap di dalam overlay tidak nutup
        child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.6,
          maxChildSize: 0.95,
          builder: (_, controller) => Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: ListView(
              controller: controller,
              children: [
                // Pegangan atas
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Header dengan tombol tutup
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Edit Pesan Warga',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: secondaryColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 12),

                // Field readonly abu-abu
                _buildReadOnly('Pengirim', widget.pesan.pengirim),
                _buildReadOnly('Judul', widget.pesan.judul),
                _buildReadOnly('Deskripsi', widget.pesan.deskripsi),
                const SizedBox(height: 8),

                // Dropdown status
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  value: status,
                  items: const [
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    DropdownMenuItem(value: 'Diterima', child: Text('Diterima')),
                    DropdownMenuItem(value: 'Ditolak', child: Text('Ditolak')),
                  ],
                  onChanged: (v) => setState(() => status = v!),
                ),

                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Simpan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Perubahan disimpan')),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnly(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: IgnorePointer(
        ignoring: true, // benar-benar nonaktif
        child: TextField(
          controller: TextEditingController(text: value),
          readOnly: true,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey.shade200, // warna abu-abu lembut
            labelStyle: const TextStyle(color: Colors.black87),
          ),
          style: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
