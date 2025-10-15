import 'package:flutter/material.dart';
import 'package:pentagram/models/dashboard_item.dart';
import 'package:pentagram/responsive.dart';
import 'package:pentagram/widgets/info_card.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // List data yang akan ditampilkan. UI dipisahkan dari data.
    final List<DashboardItem> dashboardItems = [
      DashboardItem(
        title: 'Total Kegiatan',
        icon: Icons.event,
        color: const Color(0xFFE3F2FD),
        content: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('0', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            Text('Jumlah seluruh event yang sudah ada'),
          ],
        ),
      ),
      DashboardItem(
        title: 'Kegiatan per Kategori',
        icon: Icons.category,
        color: const Color(0xFFE8F5E9),
        width: 300,
        content: Row(
          children: [
            Container(width: 40, height: 30, color: Colors.blue),
            const SizedBox(width: 8),
            Container(width: 40, height: 30, color: Colors.orange),
            const SizedBox(width: 8),
            Container(width: 40, height: 30, color: Colors.purple),
            const SizedBox(width: 8),
            Container(width: 40, height: 30, color: Colors.yellow),
          ],
        ),
      ),
      DashboardItem(
        title: 'Kegiatan berdasarkan Waktu',
        icon: Icons.access_time,
        color: const Color(0xFFFFFDE7),
        content: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sudah Lewat: 0'),
            SizedBox(height: 4),
            Text('Hari Ini: 0'),
            SizedBox(height: 4),
            Text('Akan Datang: 0'),
          ],
        ),
      ),
      DashboardItem(
        title: 'Penanggung Jawab Terbanyak',
        icon: Icons.person_pin,
        color: const Color(0xFFF3E5F5),
        content: const SizedBox(height: 20),
      ),
      DashboardItem(
        title: 'Kegiatan per Bulan (Tahun Ini)',
        icon: Icons.calendar_today,
        color: const Color(0xFFFCE4EC),
        width: 600,
        content: const SizedBox(height: 50),
      ),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: dashboardItems.map((item) {
        return SizedBox(
          // Di mobile, kartu akan full-width. Di desktop, sesuai model.
          width: Responsive.isMobile(context) ? double.infinity : item.width,
          child: InfoCard(item: item),
        );
      }).toList(),
    );
  }
}