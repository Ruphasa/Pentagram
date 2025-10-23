import 'package:flutter/material.dart';
import 'package:pentagram/models/activity.dart';
import 'package:pentagram/models/activity_log.dart';
import 'package:pentagram/pages/dashboard/activity_statistics_page.dart';
import 'package:pentagram/pages/dashboard/finance_statistics_page.dart';
import 'package:pentagram/pages/dashboard/population_statistics_page.dart';
import 'package:pentagram/services/activity_service.dart';
import 'package:pentagram/services/activity_log_service.dart';
import 'package:pentagram/pages/dashboard/components/event_card.dart';
import 'package:pentagram/pages/dashboard/components/quick_access_card.dart';
import 'package:pentagram/pages/dashboard/components/stat_card.dart';
import 'package:pentagram/pages/log_aktivitas/log_aktivitas_page.dart';
import 'package:pentagram/pages/notifikasi/notifikasi.dart';
import 'package:pentagram/pages/penerimaan_warga/penerimaan_warga_page.dart';
import 'package:pentagram/pages/profil/profil_page.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/pages/channel_transfer/daftar_channel.dart';
import 'package:pentagram/pages/manajemen_pengguna/daftar_pengguna.dart';
import 'package:pentagram/widgets/log_aktivitas_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final ActivityService _activityService = ActivityService();
  final ActivityLogService _activityLogService = ActivityLogService();

  int _currentPage = 0;
  late List<Activity> _upcomingActivities;
  late List<ActivityLog> _recentLogs;

  @override
  void initState() {
    super.initState();
    _loadData();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Load all data from services
  void _loadData() {
    setState(() {
      _upcomingActivities = _activityService.getUpcomingActivities();
      _recentLogs = _activityLogService.getRecentActivityLogs(limit: 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _buildUpcomingEventsSection(),
            const SizedBox(height: 24),
            _buildQuickAccessSection(context),
            const SizedBox(height: 24),
            _buildStatisticsSection(),
            const SizedBox(height: 24),
            _buildActivityLogSection(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Build AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
                MaterialPageRoute(builder: (context) => const ProfilPage()),
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
              MaterialPageRoute(builder: (context) => const Notifikasi()),
            );
          },
          icon: const Icon(Icons.notifications_outlined),
          color: Colors.white,
        ),
      ],
    );
  }

  /// Build Upcoming Events Section
  Widget _buildUpcomingEventsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kegiatan mendatang',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_upcomingActivities.length > 1)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_upcomingActivities.length} Kegiatan',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _upcomingActivities.isEmpty
              ? _buildEmptyEventsState()
              : _buildEventsCarousel(),
        ],
      ),
    );
  }

  /// Build Empty Events State
  Widget _buildEmptyEventsState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.event_busy_rounded, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              'Belum ada kegiatan mendatang',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build Events Carousel
  Widget _buildEventsCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _upcomingActivities.length,
            itemBuilder: (context, index) {
              return EventCard(
                activity: _upcomingActivities[index],
                index: index,
              );
            },
          ),
        ),
        if (_upcomingActivities.length > 1) ...[
          const SizedBox(height: 16),
          _buildPageIndicators(),
        ],
      ],
    );
  }

  /// Build Page Indicators
  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _upcomingActivities.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? AppColors.primary : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  /// Build Quick Access Section
  Widget _buildQuickAccessSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Akses cepat',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuickAccessCard(
                color: const Color(0xFF80CBC4),
                icon: Icons.campaign,
                label: 'Broadcast',
                onTap: () {
                  Navigator.pushNamed(context, '/broadcast');
                },
              ),
              QuickAccessCard(
                color: const Color(0xFF9575CD),
                icon: Icons.tv_rounded,
                label: 'Daftar Channel',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarChannelPage(),
                    ),
                  );
                },
              ),
              QuickAccessCard(
                color: const Color(0xFFFFB74D),
                icon: Icons.group_rounded,
                label: 'Daftar Pengguna',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DaftarPenggunaPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuickAccessCard(
                color: const Color(0xFF4DB6AC),
                icon: Icons.home_rounded,
                label: 'Penerimaan Warga',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PenerimaanWargaPage(),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8), // Placeholder untuk menjaga layout
              const SizedBox(width: 8), // Placeholder untuk menjaga layout
            ],
          ),
        ],
      ),
    );
  }

  /// Build Statistics Section
  Widget _buildStatisticsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistik',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          StatCard(
            title: 'Keuangan',
            lightColor: const Color(0xFF81C784),
            darkColor: const Color(0xFF66BB6A),
            icon: Icons.attach_money,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FinanceStatisticsPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          StatCard(
            title: 'Kegiatan',
            lightColor: const Color(0xFF64B5F6),
            darkColor: const Color(0xFF42A5F5),
            icon: Icons.grid_view,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ActivityStatisticsPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          StatCard(
            title: 'Kependudukan',
            lightColor: const Color(0xFFE57373),
            darkColor: const Color(0xFFC62828),
            icon: Icons.people,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PopulationStatisticsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build Activity Log Section
  Widget _buildActivityLogSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Log Aktivitas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ..._recentLogs.map((log) => LogAktivitasCard(aktivitas: log)),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LogAktivitasPage()),
                );
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              child: const Text('Lihat Semua →'),
            ),
          ),
        ],
      ),
    );
  }
}
