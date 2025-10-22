import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/widgets/common_header.dart';

class KegiatanPage extends StatelessWidget {
  const KegiatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar dengan Gradient
            const CommonHeader(
              title: 'Kegiatan',
            ),
            
            // Content
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildActivityCard(
                    title: 'Gotong Royong',
                    date: '25 Oktober 2025',
                    time: '08:00 - 12:00',
                    location: 'Balai Desa',
                    participants: 45,
                    status: 'Akan Datang',
                    statusColor: AppColors.info,
                  ),
                  const SizedBox(height: 12),
                  _buildActivityCard(
                    title: 'Rapat RT',
                    date: '22 Oktober 2025',
                    time: '19:00 - 21:00',
                    location: 'Rumah Ketua RT',
                    participants: 20,
                    status: 'Berlangsung',
                    statusColor: AppColors.success,
                  ),
                  const SizedBox(height: 12),
                  _buildActivityCard(
                    title: 'Posyandu',
                    date: '20 Oktober 2025',
                    time: '09:00 - 12:00',
                    location: 'Balai RW',
                    participants: 35,
                    status: 'Selesai',
                    statusColor: AppColors.textSecondary,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add activity
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, color: AppColors.textOnPrimary),
      ),
    );
  }

  Widget _buildActivityCard({
    required String title,
    required String date,
    required String time,
    required String location,
    required int participants,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.calendar_today_rounded, date),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.access_time_rounded, time),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.location_on_rounded, location),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.people_rounded, '$participants Peserta'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline_rounded, size: 18),
                  label: const Text('Detail'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_rounded, size: 18),
                  label: const Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.iconSecondary,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
