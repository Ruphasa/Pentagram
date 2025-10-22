import 'package:flutter/material.dart';
import '../../models/pesan_warga.dart';

class PesanWargaDetailOverlay extends StatelessWidget {
  final PesanWarga pesan;
  const PesanWargaDetailOverlay({super.key, required this.pesan});

  @override
  Widget build(BuildContext context) {
    const secondaryColor = Color(0xFF5a63b9);

    return GestureDetector(
      // Jika user tap di luar konten overlay → tutup
      onTap: () => Navigator.pop(context),
      behavior: HitTestBehavior.opaque,
      child: GestureDetector(
        // Tangkap event tap dalam konten agar tidak ikut nutup
        onTap: () {},
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
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
                // Pegangan kecil di atas
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

                // Header: Judul + Tombol Tutup di kanan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Detail Pesan Warga',
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

                _buildRow('Pengirim', pesan.pengirim),
                _buildRow('Judul', pesan.judul),
                _buildRow('Deskripsi', pesan.deskripsi),
                _buildRow('Status', pesan.status),
                _buildRow(
                  'Tanggal Dibuat',
                  '${pesan.tanggalDibuat.day} ${_bulan(pesan.tanggalDibuat.month)} ${pesan.tanggalDibuat.year}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }

  String _bulan(int bulan) {
    const list = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return list[bulan];
  }
}
