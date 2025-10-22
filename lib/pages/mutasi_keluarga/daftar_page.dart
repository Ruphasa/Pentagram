import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/pages/mutasi_keluarga/tambah_page.dart';
import 'package:pentagram/pages/mutasi_keluarga/detail_page.dart';

class DaftarMutasiPage extends StatelessWidget {
  DaftarMutasiPage({super.key});

  final List<Map<String, String>> dataMutasi = [
    {
      'no': '1',
      'tanggal': '15 Oktober 2025',
      'keluarga': 'Keluarga Ijat',
      'jenis': 'Keluar Wilayah',
      'alamatLama': 'Jl. Mawar No. 12',
      'alamatBaru': '-',
      'alasan': 'Karena mau keluar',
    },
    {
      'no': '2',
      'tanggal': '30 September 2025',
      'keluarga': 'Keluarga Mara Nunez',
      'jenis': 'Pindah Rumah',
      'alamatLama': 'Jl. Melati No. 7',
      'alamatBaru': 'Jl. Kenanga No. 5',
      'alasan': 'Pindah rumah baru',
    },
  ];

  void _showFilterDialog(BuildContext context) {
    String? selectedStatus;
    String? selectedKeluarga;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Filter Mutasi Keluarga'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedStatus,
                  items: const [
                    DropdownMenuItem(value: 'Pindah Rumah', child: Text('Pindah Rumah')),
                    DropdownMenuItem(value: 'Keluar Wilayah', child: Text('Keluar Wilayah')),
                  ],
                  onChanged: (value) => selectedStatus = value,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Keluarga',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedKeluarga,
                  items: dataMutasi.map((data) {
                    return DropdownMenuItem(
                      value: data['keluarga'],
                      child: Text(data['keluarga']!),
                    );
                  }).toList(),
                  onChanged: (value) => selectedKeluarga = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Reset Filter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Terapkan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        title: const Text('Daftar Mutasi Keluarga'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header Table dan Filter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daftar Mutasi',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showFilterDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        icon: const Icon(Icons.filter_list, color: Colors.white),
                        label: const Text('Filter', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),

                // Table Header
                Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: const Row(
                    children: [
                      Expanded(flex: 1, child: Text('NO')),
                      Expanded(flex: 3, child: Text('TANGGAL')),
                      Expanded(flex: 4, child: Text('KELUARGA')),
                      Expanded(flex: 3, child: Text('JENIS MUTASI')),
                      Expanded(flex: 1, child: Text('AKSI')),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // Table Rows
                ...dataMutasi.map(
                  (data) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text(data['no']!)),
                        Expanded(flex: 3, child: Text(data['tanggal']!)),
                        Expanded(flex: 4, child: Text(data['keluarga']!)),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: data['jenis'] == 'Pindah Rumah'
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: Text(
                              data['jenis']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: data['jenis'] == 'Pindah Rumah'
                                    ? Colors.green.shade800
                                    : Colors.red.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        // Tombol aksi (popup dekat tombol)
                        Expanded(
                          flex: 1,
                          child: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'detail') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailMutasiPage(data: data),
                                  ),
                                );
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'detail',
                                child: Text('Detail'),
                              ),
                            ],
                            child: const Icon(Icons.more_vert, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Tombol Tambah
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C63FF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahMutasiPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
