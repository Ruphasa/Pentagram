import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pentagram/models/dashboard_item.dart';
import 'package:pentagram/responsive.dart';
import 'package:pentagram/widgets/info_card.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DashboardItem> dashboardItems = [
      DashboardItem(
        title: 'Total Kegiatan',
        icon: Icons.event,
        color: const Color(0xFFE3F2FD),
        content: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '0',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
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
        content: Column(
          children: [
            TextFormField(
              initialValue: 'Pak Budi',
              decoration: const InputDecoration(border: OutlineInputBorder()),
              readOnly: true,
            ),
          ],
        ),
      ),
      DashboardItem(
        title: 'Kegiatan per Bulan (Tahun Ini)',
        icon: Icons.calendar_today,
        color: const Color(0xFFFCE4EC),
        width: 600,
        content: Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 1.2,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const months = [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                          'Jul',
                          'Aug',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec',
                        ];
                        if (value.toInt() >= 0 &&
                            value.toInt() < months.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Transform.rotate(
                              angle: -0.785398, // -45 degrees in radians
                              child: Text(
                                months[value.toInt()],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize:
                          50, // Increased reserved size for rotated text
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value.toString(),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                      reservedSize: 40,
                      interval: 0.25,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 0.25,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    left: BorderSide(color: Colors.grey.withOpacity(0.3)),
                  ),
                ),
                barGroups: [
                  // Sample data - you can replace with actual data
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 0.5,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 0.8,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 0.3,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 0.7,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 0.9,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [
                      BarChartRodData(
                        toY: 0.6,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 6,
                    barRods: [
                      BarChartRodData(
                        toY: 0.4,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 7,
                    barRods: [
                      BarChartRodData(
                        toY: 0.8,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 8,
                    barRods: [
                      BarChartRodData(
                        toY: 0.5,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 9,
                    barRods: [
                      BarChartRodData(
                        toY: 1.0,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 10,
                    barRods: [
                      BarChartRodData(
                        toY: 0.7,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 11,
                    barRods: [
                      BarChartRodData(
                        toY: 0.3,
                        color: const Color(0xFFE91E63),
                        width: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
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
