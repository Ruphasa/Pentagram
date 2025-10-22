import 'package:flutter/material.dart';
import 'package:pentagram/models/pesan_warga.dart';
import 'package:pentagram/widgets/app_header.dart';
import 'package:pentagram/widgets/pesan_table.dart';
import 'package:pentagram/widgets/filter_pesan_dialog.dart';
import 'package:pentagram/pages/pesan_warga/pesan_warga_detail.dart';
import 'package:pentagram/pages/pesan_warga/pesan_warga_edit.dart';

class PesanWargaPage extends StatefulWidget {
  const PesanWargaPage({super.key});

  @override
  State<PesanWargaPage> createState() => _PesanWargaPageState();
}

class _PesanWargaPageState extends State<PesanWargaPage> {
  int currentPage = 1;
  final int totalPages = 10;

  // Filter state
  String filterJudul = '';
  String? filterStatus;

  List<PesanWarga> pesanList = [
    PesanWarga(
      id: 1,
      pengirim: 'Varizky Naldiba Rimra',
      judul: 'Titootit',
      deskripsi: 'Mobile igmana bang',
      status: 'Diterima',
      tanggalDibuat: DateTime(2025, 10, 16),
    ),
    PesanWarga(
      id: 2,
      pengirim: 'Habibie Ed Dien',
      judul: 'Tes',
      deskripsi: 'Isi tes',
      status: 'Pending',
      tanggalDibuat: DateTime(2025, 9, 28),
    ),
    PesanWarga(
      id: 3,
      pengirim: 'Alya Rahmadina',
      judul: 'Kritik Kebersihan',
      deskripsi: 'Tolong diperhatikan kebersihan taman kampus.',
      status: 'Ditolak',
      tanggalDibuat: DateTime(2025, 10, 12),
    ),
  ];

  void _openFilter() {
    showDialog(
      context: context,
      builder: (_) => FilterPesanDialog(
        onFilter: (judul, status) {
          setState(() {
            filterJudul = judul ?? '';
            filterStatus = status;
          });
        },
      ),
    );
  }

  void _showDetail(PesanWarga pesan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PesanWargaDetailOverlay(pesan: pesan),
    );
  }

  void _showEdit(PesanWarga pesan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PesanWargaEditOverlay(pesan: pesan),
    );
  }

  // Simulasi data hasil filter
  List<PesanWarga> get _filteredPesan {
    return pesanList.where((p) {
      final cocokJudul = filterJudul.isEmpty ||
          p.judul.toLowerCase().contains(filterJudul.toLowerCase());
      final cocokStatus = filterStatus == null || p.status == filterStatus;
      return cocokJudul && cocokStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const secondaryColor = Color(0xFF5A63B9);
    final bool isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _openFilter,
                icon: const Icon(Icons.filter_list, size: 20),
                label: const Text('Filter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // === TABEL PESAN (dengan pagination seperti aktivitas) ===
            Expanded(
              child: TablePesanWarga(
                data: _filteredPesan,
                currentPage: currentPage,
                totalPages: totalPages,
                onPageChanged: (page) => setState(() => currentPage = page),
                isMobile: isMobile,
                onView: _showDetail,
                onEdit: _showEdit,
                onDelete: (p) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
