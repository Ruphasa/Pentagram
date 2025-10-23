import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'detail_channel_page.dart';
import 'tambah_channel.dart'; // arah ke file lib/pages/channel_transfer/tambah_channel.dart

class DaftarChannelPage extends StatelessWidget {
  const DaftarChannelPage({super.key});

  final List<Map<String, String>> channelData = const [
    {
      'nama': 'Transfer via BCA',
      'tipe': 'Bank',
      'an': 'RT Jawara Karangploso',
      'thumbnail': 'assets/icons/bank.png',
    },
    {
      'nama': 'Gopay Ketua RT',
      'tipe': 'E-Wallet',
      'an': 'Budi Santoso',
      'thumbnail': 'assets/icons/ewallet.png',
    },
    {
      'nama': 'QRIS Resmi RT 08',
      'tipe': 'QRIS',
      'an': 'RW 08 Karangploso',
      'thumbnail': 'assets/icons/qris.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Daftar Channel Transfer',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
      ),

      // === Tombol Tambah Channel ===
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahChannelPage(),
            ),
          );
        },
        child: Builder(
          builder: (context) {
            final screenWidth = MediaQuery.of(context).size.width;
            final isCompact = screenWidth < 400;
            return Icon(
              Icons.add,
              color: Colors.white,
              size: isCompact ? 24 : 28,
            );
          },
        ),
      ),

      // === Daftar Channel ===
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: channelData.length,
          itemBuilder: (context, index) {
            final data = channelData[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                title: Text(
                  data['nama']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'Tipe: ${data['tipe']}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      'A/N: ${data['an']}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailChannelPage(data: data),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Detail',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios,
                          color: AppColors.primary, size: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
