import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/widgets/simple_info_card.dart';
import 'package:pentagram/widgets/common_header.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar dengan Gradient
            const CommonHeader(title: 'Beranda'),
            
            // Content
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Info Cards Row
                  const Row(
                    children: [
                      Expanded(
                        child: SimpleInfoCard(
                          title: 'Total Warga',
                          value: '1,234',
                          icon: Icons.people_rounded,
                          gradientColors: [
                            AppColors.gradientStart,
                            AppColors.gradientMiddle,
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: SimpleInfoCard(
                          title: 'Keluarga',
                          value: '456',
                          icon: Icons.home_rounded,
                          gradientColors: [
                            AppColors.gradientMiddle,
                            AppColors.gradientEnd,
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Second Row
                  const Row(
                    children: [
                      Expanded(
                        child: SimpleInfoCard(
                          title: 'Kegiatan',
                          value: '12',
                          icon: Icons.event_rounded,
                          gradientColors: [
                            AppColors.secondary,
                            AppColors.secondaryLight,
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: SimpleInfoCard(
                          title: 'Keuangan',
                          value: 'Rp 10M',
                          icon: Icons.account_balance_wallet_rounded,
                          gradientColors: [
                            AppColors.primary,
                            AppColors.primaryLight,
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Quick Actions Section
                  _buildSectionTitle('Aksi Cepat'),
                  const SizedBox(height: 12),
                  _buildQuickActions(context),
                  const SizedBox(height: 24),
                  
                  // Recent Activity Section
                  _buildSectionTitle('Aktivitas Terbaru'),
                  const SizedBox(height: 12),
                  _buildRecentActivities(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
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
        children: [
          _buildQuickActionItem(
            icon: Icons.person_add_rounded,
            title: 'Tambah Warga',
            subtitle: 'Daftarkan warga baru',
            onTap: () {},
          ),
          const Divider(height: 24),
          _buildQuickActionItem(
            icon: Icons.event_available_rounded,
            title: 'Buat Kegiatan',
            subtitle: 'Jadwalkan kegiatan baru',
            onTap: () {},
          ),
          const Divider(height: 24),
          _buildQuickActionItem(
            icon: Icons.payment_rounded,
            title: 'Input Keuangan',
            subtitle: 'Catat transaksi keuangan',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.textOnPrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.iconSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities() {
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
        children: [
          _buildActivityItem(
            icon: Icons.person_add_rounded,
            title: 'Warga baru ditambahkan',
            subtitle: 'John Doe - 2 jam yang lalu',
            color: AppColors.primary,
          ),
          const Divider(height: 24),
          _buildActivityItem(
            icon: Icons.event_rounded,
            title: 'Kegiatan dijadwalkan',
            subtitle: 'Gotong Royong - Besok 08:00',
            color: AppColors.secondary,
          ),
          const Divider(height: 24),
          _buildActivityItem(
            icon: Icons.payment_rounded,
            title: 'Transaksi dicatat',
            subtitle: 'Pemasukan Rp 500.000 - Hari ini',
            color: AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
