import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/pages/mutasi_keluarga/daftar_page.dart';
import 'package:pentagram/pages/masyarakat/tambah_warga_page.dart';
import 'package:pentagram/pages/masyarakat/tambah_keluarga_page.dart';
import 'package:pentagram/pages/masyarakat/tambah_rumah_page.dart';

class MasyarakatPage extends StatefulWidget {
  const MasyarakatPage({super.key});

  @override
  State<MasyarakatPage> createState() => _MasyarakatPageState();
}

class _MasyarakatPageState extends State<MasyarakatPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedFilter = 'Semua';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Refresh FAB when tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onFabPressed() {
    switch (_tabController.index) {
      case 0: // Warga
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TambahWargaPage(),
          ),
        );
        break;
      case 1: // Keluarga
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TambahKeluargaPage(),
          ),
        );
        break;
      case 2: // Rumah
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TambahRumahPage(),
          ),
        );
        break;
    }
  }

  String _getFabLabel() {
    switch (_tabController.index) {
      case 0:
        return 'Tambah Warga';
      case 1:
        return 'Tambah Keluarga';
      case 2:
        return 'Tambah Rumah';
      default:
        return 'Tambah';
    }
  }

  IconData _getFabIcon() {
    switch (_tabController.index) {
      case 0:
        return Icons.person_add_rounded;
      case 1:
        return Icons.family_restroom_rounded;
      case 2:
        return Icons.home_rounded;
      default:
        return Icons.add_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        title: const Text('Masyarakat'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.secondary,
          labelColor: AppColors.textOnPrimary,
          unselectedLabelColor: AppColors.textPrimary,
          tabs: const [
            Tab(text: 'Warga', icon: Icon(Icons.people_rounded)),
            Tab(text: 'Keluarga', icon: Icon(Icons.family_restroom_rounded)),
            Tab(text: 'Rumah', icon: Icon(Icons.home_rounded)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWargaTab(),
          _buildKeluargaTab(),
          _buildRumahTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onFabPressed,
        backgroundColor: AppColors.primary,
        icon: Icon(_getFabIcon(), color: AppColors.textOnPrimary),
        label: Text(
          _getFabLabel(),
          style: const TextStyle(
            color: AppColors.textOnPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildWargaTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Cari warga...',
                hintStyle: TextStyle(color: AppColors.textMuted),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.iconPrimary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Semua'),
                const SizedBox(width: 8),
                _buildFilterChip('Kepala Keluarga'),
                const SizedBox(width: 8),
                _buildFilterChip('Aktif'),
                const SizedBox(width: 8),
                _buildFilterChip('Tidak Aktif'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Warga List
          _buildWargaCard(
            name: 'Ahmad Subarjo',
            nik: '3201012345678901',
            role: 'Kepala Keluarga',
            status: 'Aktif',
            statusColor: AppColors.success,
          ),
          const SizedBox(height: 12),
          _buildWargaCard(
            name: 'Siti Nurhaliza',
            nik: '3201012345678902',
            role: 'Istri',
            status: 'Aktif',
            statusColor: AppColors.success,
          ),
          const SizedBox(height: 12),
          _buildWargaCard(
            name: 'Budi Santoso',
            nik: '3201012345678903',
            role: 'Kepala Keluarga',
            status: 'Aktif',
            statusColor: AppColors.success,
          ),
          const SizedBox(height: 12),
          _buildWargaCard(
            name: 'Dewi Lestari',
            nik: '3201012345678904',
            role: 'Anak',
            status: 'Tidak Aktif',
            statusColor: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildKeluargaTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Button Mutasi Keluarga
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DaftarMutasiPage(),
                  ),
                );
              },
              icon: const Icon(Icons.swap_horiz_rounded),
              label: const Text('Lihat Mutasi Keluarga'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.textOnPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Keluarga List
          _buildKeluargaCard(
            namaKeluarga: 'Keluarga Ahmad Subarjo',
            kepalaKeluarga: 'Ahmad Subarjo',
            jumlahAnggota: 4,
            alamat: 'Jl. Mawar No. 12',
          ),
          const SizedBox(height: 12),
          _buildKeluargaCard(
            namaKeluarga: 'Keluarga Budi Santoso',
            kepalaKeluarga: 'Budi Santoso',
            jumlahAnggota: 3,
            alamat: 'Jl. Melati No. 8',
          ),
          const SizedBox(height: 12),
          _buildKeluargaCard(
            namaKeluarga: 'Keluarga Andi Wijaya',
            kepalaKeluarga: 'Andi Wijaya',
            jumlahAnggota: 5,
            alamat: 'Jl. Anggrek No. 15',
          ),
        ],
      ),
    );
  }

  Widget _buildRumahTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildRumahCard(
            alamat: 'Jl. Mawar No. 12',
            rt: '08',
            rw: '03',
            kepalaKeluarga: 'Ahmad Subarjo',
            status: 'Ditempati',
            statusColor: AppColors.success,
          ),
          const SizedBox(height: 12),
          _buildRumahCard(
            alamat: 'Jl. Melati No. 8',
            rt: '08',
            rw: '03',
            kepalaKeluarga: 'Budi Santoso',
            status: 'Ditempati',
            statusColor: AppColors.success,
          ),
          const SizedBox(height: 12),
          _buildRumahCard(
            alamat: 'Jl. Anggrek No. 15',
            rt: '08',
            rw: '03',
            kepalaKeluarga: 'Andi Wijaya',
            status: 'Ditempati',
            statusColor: AppColors.success,
          ),
          const SizedBox(height: 12),
          _buildRumahCard(
            alamat: 'Jl. Dahlia No. 20',
            rt: '08',
            rw: '03',
            kepalaKeluarga: '-',
            status: 'Kosong',
            statusColor: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          color: isSelected ? null : AppColors.backgroundGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? AppColors.textOnPrimary
                : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildWargaCard({
    required String name,
    required String nik,
    required String role,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: AppColors.textOnPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nik,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.family_restroom_rounded,
                size: 16,
                color: AppColors.iconSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                role,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: const Text('Detail'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeluargaCard({
    required String namaKeluarga,
    required String kepalaKeluarga,
    required int jumlahAnggota,
    required String alamat,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.family_restroom_rounded,
                  color: AppColors.textOnPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaKeluarga,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'KK: $kepalaKeluarga',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$jumlahAnggota Anggota',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                size: 16,
                color: AppColors.iconSecondary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  alamat,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: const Text('Detail'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRumahCard({
    required String alamat,
    required String rt,
    required String rw,
    required String kepalaKeluarga,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.home_rounded,
                  color: AppColors.textOnPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alamat,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'RT $rt / RW $rw',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.person_rounded,
                size: 16,
                color: AppColors.iconSecondary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  kepalaKeluarga == '-' ? 'Tidak ada penghuni' : kepalaKeluarga,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: const Text('Detail'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
