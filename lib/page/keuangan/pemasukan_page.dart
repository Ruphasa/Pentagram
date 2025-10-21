import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pentagram/models/transaksi.dart';
import 'package:pentagram/widgets/transaksi_card.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/utils/icon_mapper.dart';

class PemasukanPage extends StatefulWidget {
  const PemasukanPage({super.key});

  @override
  State<PemasukanPage> createState() => _PemasukanPageState();
}

class _PemasukanPageState extends State<PemasukanPage> {
  final List<Transaksi> _pemasukanList = [
    Transaksi(
      id: '1',
      jenis: 'pemasukan',
      keterangan: 'Gaji Bulanan',
      jumlah: 3000000,
      tanggal: DateTime(2025, 10, 1),
    ),
    Transaksi(
      id: '2',
      jenis: 'pemasukan',
      keterangan: 'Bonus Proyek',
      jumlah: 750000,
      tanggal: DateTime(2025, 10, 5),
    ),
  ];

  double get _totalPemasukan =>
      _pemasukanList.fold(0, (sum, item) => sum + item.jumlah);

  void _tambahPemasukan() {
    final TextEditingController keteranganCtrl = TextEditingController();
    final TextEditingController jumlahCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.backgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.cyan.withOpacity(0.3), width: 1),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.cyan.withOpacity(0.05),
                AppColors.backgroundDark,
                AppColors.magenta.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cyan.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      iconFromKey('arrow_downward'),
                      color: AppColors.cyan,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Tambah Pemasukan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: keteranganCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: "Keterangan",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  prefixIcon: Icon(
                    iconFromKey('list_alt'),
                    color: AppColors.cyan,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppColors.cyan.withOpacity(0.8), width: 2),
                  ),
                  filled: true,
                  fillColor: AppColors.border.withOpacity(0.3),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: jumlahCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: "Jumlah",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  prefixIcon: Icon(
                    iconFromKey('attach_money'),
                    color: AppColors.cyan,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppColors.cyan.withOpacity(0.8), width: 2),
                  ),
                  filled: true,
                  fillColor: AppColors.border.withOpacity(0.3),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Batal"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (keteranganCtrl.text.isEmpty ||
                          jumlahCtrl.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Harap isi semua field'),
                            backgroundColor: AppColors.error,
                          ),
                        );
                        return;
                      }
                      setState(() {
                        _pemasukanList.add(Transaksi(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          jenis: 'pemasukan',
                          keterangan: keteranganCtrl.text,
                          jumlah: double.tryParse(jumlahCtrl.text) ?? 0,
                          tanggal: DateTime.now(),
                        ));
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cyan,
                      foregroundColor: AppColors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Simpan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Pemasukan",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(iconFromKey('history'), color: AppColors.cyan),
            onPressed: () {
              // TODO: Tambahkan aksi filter/history
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [AppColors.cyan, AppColors.cyan.withOpacity(0.8)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyan.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: _tambahPemasukan,
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: Icon(iconFromKey('add'), color: AppColors.black),
          label: const Text(
            "Tambah",
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Summary Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.cyan.withOpacity(0.2),
                  AppColors.cyan.withOpacity(0.05),
                ],
              ),
              border: Border.all(
                color: AppColors.cyan.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cyan.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    iconFromKey('arrow_downward'),
                    color: AppColors.cyan,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Pemasukan",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(_totalPemasukan),
                        style: const TextStyle(
                          color: AppColors.cyan,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text(
                  "Riwayat Transaksi",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.cyan.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${_pemasukanList.length}",
                    style: const TextStyle(
                      color: AppColors.cyan,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: _pemasukanList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconFromKey('inbox'),
                          size: 64,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Belum ada pemasukan",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _pemasukanList.length,
                    itemBuilder: (context, index) {
                      return TransaksiCard(
                        transaksi: _pemasukanList[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
