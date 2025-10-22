import 'package:flutter/material.dart';
import 'package:pentagram/models/transaksi.dart';
import 'package:pentagram/widgets/transaksi_card.dart';
import 'package:pentagram/pages/keuangan/pengeluaran_page.dart';
import 'package:pentagram/utils/app_colors.dart';

class PemasukanPage extends StatefulWidget {
  const PemasukanPage({super.key});

  @override
  State<PemasukanPage> createState() => _PemasukanPageState();
}

class _PemasukanPageState extends State<PemasukanPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _tambahPemasukan() {
    final TextEditingController keteranganCtrl = TextEditingController();
    final TextEditingController jumlahCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Pemasukan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keteranganCtrl,
              decoration: const InputDecoration(labelText: 'Keterangan'),
            ),
            TextField(
              controller: jumlahCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
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
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        title: const Text('Keuangan'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur cetak laporan akan segera hadir'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            icon: const Icon(Icons.print_rounded),
            tooltip: 'Cetak Laporan',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.secondary,
          labelColor: AppColors.textOnPrimary,
          unselectedLabelColor: AppColors.textOnPrimary,
          tabs: const [
            Tab(text: 'Pemasukan', icon: Icon(Icons.arrow_downward_rounded)),
            Tab(text: 'Pengeluaran', icon: Icon(Icons.arrow_upward_rounded)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab Pemasukan
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _pemasukanList.length,
            itemBuilder: (context, index) {
              return TransaksiCard(transaksi: _pemasukanList[index]);
            },
          ),
          // Tab Pengeluaran
          const PengeluaranPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahPemasukan,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, color: AppColors.textOnPrimary),
      ),
    );
  }
}
