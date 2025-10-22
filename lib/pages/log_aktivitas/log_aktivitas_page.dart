import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/widgets/filter_aktivitas_dialog.dart';
import 'package:pentagram/models/aktivitas_data.dart';

class LogAktivitasPage extends StatefulWidget {
  const LogAktivitasPage({super.key});

  @override
  State<LogAktivitasPage> createState() => _LogAktivitasPageState();
}

class _LogAktivitasPageState extends State<LogAktivitasPage> {
  final TextEditingController _searchController = TextEditingController();

  void _showFilterDialog() async {
    await showDialog(
      context: context,
      builder: (context) => const FilterAktivitasDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Log Aktivitas'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar + Filter Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Search Field 
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari aktivitas atau pelaku...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Filter Button
                InkWell(
                  onTap: _showFilterDialog,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.filter_list_rounded,
                      color: AppColors.textOnPrimary,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Daftar Aktivitas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: aktivitasData.length,
              itemBuilder: (context, index) {
                final aktivitas = aktivitasData[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      child: Text(
                        aktivitas.avatar,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      aktivitas.deskripsi,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      "${aktivitas.aktor}  •  ${aktivitas.tanggal}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    trailing:
                        null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
