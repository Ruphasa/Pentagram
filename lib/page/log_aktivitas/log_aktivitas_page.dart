import 'package:flutter/material.dart';
import 'package:pentagram/widgets/side_menu.dart';
import 'package:pentagram/page/log_aktivitas/aktivitas_data.dart';
import 'package:pentagram/page/log_aktivitas/aktivitas_table.dart';
import 'package:pentagram/page/log_aktivitas/filter_dialog.dart';

class LogAktivitasPage extends StatefulWidget {
  const LogAktivitasPage({super.key});

  @override
  State<LogAktivitasPage> createState() => _LogAktivitasPageState();
}

class _LogAktivitasPageState extends State<LogAktivitasPage> {
  int currentPage = 1;
  final int totalPages = 10;

  // Filter state
  String filterDeskripsi = '';
  String filterNamaPelaku = '';
  DateTime? filterDariTanggal;
  DateTime? filterSampaiTanggal;

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterAktivitasDialog(
          initialDeskripsi: filterDeskripsi,
          initialNamaPelaku: filterNamaPelaku,
          initialDariTanggal: filterDariTanggal,
          initialSampaiTanggal: filterSampaiTanggal,
          onApply: (deskripsi, namaPelaku, dari, sampai) {
            setState(() {
              filterDeskripsi = deskripsi;
              filterNamaPelaku = namaPelaku;
              filterDariTanggal = dari;
              filterSampaiTanggal = sampai;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Semua Aktivitas', style: TextStyle(color: Colors.white)),
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _showFilterDialog,
                icon: const Icon(Icons.filter_list, size: 20),
                label: const Text('Filter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AktivitasTable(
                aktivitasData: aktivitasData,
                currentPage: currentPage,
                totalPages: totalPages,
                onPageChanged: (p) => setState(() => currentPage = p),
                isMobile: isMobile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
