import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';

class DaftarChannelPage extends StatelessWidget {
  DaftarChannelPage({super.key});

  final List<Map<String, String>> channelData = [
    {
      'no': '1',
      'nama': 'Transfer via BCA',
      'tipe': 'bank',
      'an': 'RT Jawara Karangploso',
      'thumbnail': '-',
    },
    {
      'no': '2',
      'nama': 'Gopay Ketua RT',
      'tipe': 'ewallet',
      'an': 'Budi Santoso',
      'thumbnail': '-',
    },
    {
      'no': '3',
      'nama': 'QRIS Resmi RT 08',
      'tipe': 'qris',
      'an': 'RW 08 Karangploso',
      'thumbnail': '-',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        title: const Text('Daftar Channel Transfer'),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daftar Channel',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tabel header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Expanded(flex: 1, child: Text('NO')),
                            Expanded(flex: 3, child: Text('NAMA')),
                            Expanded(flex: 2, child: Text('TIPE')),
                            Expanded(flex: 3, child: Text('A/N')),
                            Expanded(flex: 2, child: Text('THUMBNAIL')),
                            Expanded(flex: 1, child: Text('AKSI')),
                          ],
                        ),
                      ),
                      const Divider(height: 0),

                      // Data rows
                      ...channelData.map((data) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: int.parse(data['no']!) % 2 == 0
                                ? Colors.grey.shade50
                                : Colors.white,
                            border: const Border(
                              bottom: BorderSide(
                                color: Color(0xFFE0E0E0),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(flex: 1, child: Text(data['no']!)),
                              Expanded(flex: 3, child: Text(data['nama']!)),
                              Expanded(flex: 2, child: Text(data['tipe']!)),
                              Expanded(flex: 3, child: Text(data['an']!)),
                              Expanded(flex: 2, child: Text(data['thumbnail']!)),
                              const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 24),

                      // Pagination
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chevron_left),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
