import 'package:flutter/material.dart';
import 'package:pentagram/models/aktivitas_data.dart';
import 'package:pentagram/pages/log_aktivitas/log_aktivitas_page.dart';
import 'package:pentagram/pages/notifikasi/notifikasi.dart';
import 'package:pentagram/pages/profil/profil_page.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/pages/channel_transfer/daftar_channel.dart';
import 'package:pentagram/pages/manajemen_pengguna/daftar_pengguna.dart';
import 'package:pentagram/widgets/aktivitas_card.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilPage(),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Selamat pagi, Bu RT!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Notifikasi(),
                ),
              );
            },
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            
            // Upcoming Event Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kegiatan yang akan datang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8C5F2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Musyawarah Agustusan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                                const Text(
                                  '12 Agustus 2025',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Tempat',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                                const Text(
                                  'Rumah Pak Heri',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Carousel indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: index == 0 ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: index == 0 ? Colors.black : Colors.black38,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Quick Access Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Akses cepat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // === Broadcast ===
                      _buildQuickAccessCard(
                        context,
                        color: const Color(0xFF80CBC4),
                        icon: Icons.campaign,
                        label: 'Broadcast',
                        onTap: () {
                          // Arahkan ke halaman Broadcast yang sudah ada
                          Navigator.pushNamed(context, '/broadcast');
                        },
                      ),

                      // === Daftar Channel ===
                      _buildQuickAccessCard(
                        context,
                        color: const Color(0xFF9575CD),
                        icon: Icons.tv_rounded,
                        label: 'Daftar Channel',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                   DaftarChannelPage(), // lib/pages/channel_transfer/tambah_channel.dart
                            ),
                          );
                        },
                      ),

                      // === Daftar Pengguna ===
                      _buildQuickAccessCard(
                        context,
                        color: const Color(0xFFFFB74D),
                        icon: Icons.group_rounded,
                        label: 'Daftar Pengguna',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DaftarPenggunaPage(), // lib/pages/manajemen_pengguna/daftar_pengguna.dart
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            
            const SizedBox(height: 24),
            
            // Statistics Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistik',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Keuangan',
                    const Color(0xFF81C784),
                    const Color(0xFF66BB6A),
                    Icons.attach_money,
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Kegiatan',
                    const Color(0xFF64B5F6),
                    const Color(0xFF42A5F5),
                    Icons.grid_view,
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Kependudukan',
                    const Color(0xFFE57373),
                    const Color(0xFFC62828),
                    Icons.people,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // Log Aktivitas Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Log Aktivitas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Card log aktivitas (3 terbaru)
                  Column(
                    children: aktivitasData.take(3).map((data) {
                      return AktivitasCard(aktivitas: data);
                    }).toList(),
                  ),

                  const SizedBox(height: 8),

                  // Tombol Lihat Semua
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LogAktivitasPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text('Lihat Semua →'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, Color lightColor, Color darkColor, IconData icon) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: darkColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessCard(
  BuildContext context, {
  required Color color,
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

}