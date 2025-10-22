import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';

class PesanWargaPage extends StatefulWidget {
  const PesanWargaPage({super.key});

  @override
  State<PesanWargaPage> createState() => _PesanWargaPageState();
}

class _PesanWargaPageState extends State<PesanWargaPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'Semua';

  final List<Map<String, dynamic>> _pesanList = [
    {
      'nama': 'Ahmad Subarjo',
      'pesan': 'Kapan ada rapat RT bulan ini?',
      'waktu': '10:30',
      'unread': true,
      'avatar': 'AS',
    },
    {
      'nama': 'Budi Santoso',
      'pesan': 'Terima kasih atas informasinya',
      'waktu': 'Kemarin',
      'unread': false,
      'avatar': 'BS',
    },
    {
      'nama': 'Siti Aminah',
      'pesan': 'Bagaimana cara membayar iuran bulanan?',
      'waktu': '2 hari lalu',
      'unread': true,
      'avatar': 'SA',
    },
    {
      'nama': 'Andi Wijaya',
      'pesan': 'Mohon informasi jadwal kerja bakti',
      'waktu': '3 hari lalu',
      'unread': false,
      'avatar': 'AW',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        title: const Text('Pesan Warga'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: AppColors.textOnPrimary),
              decoration: InputDecoration(
                hintText: 'Cari pesan...',
                hintStyle: TextStyle(color: AppColors.textOnPrimary.withOpacity(0.7)),
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textOnPrimary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, color: AppColors.textOnPrimary),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Filter Chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Semua', Icons.all_inbox_rounded),
                  const SizedBox(width: 8),
                  _buildFilterChip('Belum Dibaca', Icons.mark_email_unread_rounded),
                  const SizedBox(width: 8),
                  _buildFilterChip('Sudah Dibaca', Icons.drafts_rounded),
                ],
              ),
            ),
          ),

          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _pesanList.length,
              itemBuilder: (context, index) {
                final pesan = _pesanList[index];
                return _buildPesanCard(pesan);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
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
          color: isSelected ? null : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppColors.textOnPrimary : AppColors.iconPrimary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPesanCard(Map<String, dynamic> pesan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: pesan['unread'] ? AppColors.primary.withOpacity(0.3) : AppColors.border,
          width: pesan['unread'] ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to detail pesan
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Buka detail pesan dari ${pesan['nama']}'),
                backgroundColor: AppColors.primary,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      pesan['avatar'],
                      style: const TextStyle(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              pesan['nama'],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: pesan['unread'] ? FontWeight.bold : FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Text(
                            pesan['waktu'],
                            style: TextStyle(
                              fontSize: 12,
                              color: pesan['unread'] ? AppColors.primary : AppColors.textSecondary,
                              fontWeight: pesan['unread'] ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        pesan['pesan'],
                        style: TextStyle(
                          fontSize: 14,
                          color: pesan['unread'] ? AppColors.textPrimary : AppColors.textSecondary,
                          fontWeight: pesan['unread'] ? FontWeight.w500 : FontWeight.normal,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Unread Indicator
                if (pesan['unread'])
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(left: 8, top: 4),
                    decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Filter Pesan',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogOption('Semua', Icons.all_inbox_rounded),
            _buildDialogOption('Belum Dibaca', Icons.mark_email_unread_rounded),
            _buildDialogOption('Sudah Dibaca', Icons.drafts_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogOption(String label, IconData icon) {
    final isSelected = selectedFilter == label;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.iconPrimary,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
          : null,
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
        Navigator.pop(context);
      },
    );
  }
}
