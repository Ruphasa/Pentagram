import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/utils/responsive_helper.dart';
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
    final responsive = context.responsive;
    String? selectedStatus;
    String? selectedKeluarga;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(responsive.borderRadius(12)),
          ),
          title: Text(
            'Filter Mutasi Keluarga',
            style: TextStyle(fontSize: responsive.fontSize(18)),
          ),
          content: SizedBox(
            width: responsive.responsive<double>(
              mobile: MediaQuery.of(context).size.width * 0.8,
              tablet: 400,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Status',
                    labelStyle: TextStyle(fontSize: responsive.fontSize(14)),
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: responsive.fontSize(14), color: Colors.black),
                  value: selectedStatus,
                  items: const [
                    DropdownMenuItem(value: 'Pindah Rumah', child: Text('Pindah Rumah')),
                    DropdownMenuItem(value: 'Keluar Wilayah', child: Text('Keluar Wilayah')),
                  ],
                  onChanged: (value) => selectedStatus = value,
                ),
                SizedBox(height: responsive.spacing(16)),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Keluarga',
                    labelStyle: TextStyle(fontSize: responsive.fontSize(14)),
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: responsive.fontSize(14), color: Colors.black),
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
              child: Text(
                'Reset Filter',
                style: TextStyle(fontSize: responsive.fontSize(14)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.padding(16),
                  vertical: responsive.padding(10),
                ),
              ),
              child: Text(
                'Terapkan',
                style: TextStyle(fontSize: responsive.fontSize(14)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        title: Text(
          'Daftar Mutasi Keluarga',
          style: TextStyle(fontSize: responsive.fontSize(18)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(responsive.padding(24)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(responsive.borderRadius(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: responsive.elevation(6),
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header Table dan Filter
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.padding(16),
                    vertical: responsive.padding(20),
                  ),
                  child: responsive.isCompact
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Daftar Mutasi',
                              style: TextStyle(
                                fontSize: responsive.fontSize(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: responsive.spacing(12)),
                            ElevatedButton.icon(
                              onPressed: () => _showFilterDialog(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6C63FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(responsive.borderRadius(8)),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: responsive.padding(12), // Reduced horizontal padding
                                  vertical: responsive.padding(8), // Reduced vertical padding
                                ),
                              ),
                              icon: Icon(
                                Icons.filter_list,
                                color: Colors.white,
                                size: responsive.iconSize(18), // Reduced icon size
                              ),
                              label: Text(
                                'Filter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsive.fontSize(12), // Reduced font size
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Daftar Mutasi',
                              style: TextStyle(
                                fontSize: responsive.fontSize(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => _showFilterDialog(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6C63FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(responsive.borderRadius(8)),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: responsive.padding(12), // Reduced horizontal padding
                                  vertical: responsive.padding(8), // Reduced vertical padding
                                ),
                              ),
                              icon: Icon(
                                Icons.filter_list,
                                color: Colors.white,
                                size: responsive.iconSize(18), // Reduced icon size
                              ),
                              label: Text(
                                'Filter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsive.fontSize(12), // Reduced font size
                                ),
                              ),
                            ),
                          ],
                        ),
                ),

                // Table Header
                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.padding(16),
                    vertical: responsive.padding(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'NO',
                          style: TextStyle(
                            fontSize: responsive.fontSize(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'TANGGAL',
                          style: TextStyle(
                            fontSize: responsive.fontSize(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'KELUARGA',
                          style: TextStyle(
                            fontSize: responsive.fontSize(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'JENIS MUTASI',
                          style: TextStyle(
                            fontSize: responsive.fontSize(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'AKSI',
                          style: TextStyle(
                            fontSize: responsive.fontSize(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // Table Rows
                ...dataMutasi.map(
                  (data) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.padding(16),
                      vertical: responsive.padding(14),
                    ),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            data['no']!,
                            style: TextStyle(fontSize: responsive.fontSize(14)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data['tanggal']!,
                            style: TextStyle(fontSize: responsive.fontSize(14)),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            data['keluarga']!,
                            style: TextStyle(fontSize: responsive.fontSize(14)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: data['jenis'] == 'Pindah Rumah'
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(responsive.borderRadius(16)),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.padding(12),
                              vertical: responsive.padding(6),
                            ),
                            child: Text(
                              data['jenis']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: data['jenis'] == 'Pindah Rumah'
                                    ? Colors.green.shade800
                                    : Colors.red.shade800,
                                fontWeight: FontWeight.w500,
                                fontSize: responsive.fontSize(12),
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
                              PopupMenuItem(
                                value: 'detail',
                                child: Text(
                                  'Detail',
                                  style: TextStyle(fontSize: responsive.fontSize(14)),
                                ),
                              ),
                            ],
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                              size: responsive.iconSize(20),
                            ),
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
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: responsive.iconSize(28),
        ),
      ),
    );
  }
}
