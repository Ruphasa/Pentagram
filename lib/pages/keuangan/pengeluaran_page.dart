import 'package:flutter/material.dart';
import 'package:pentagram/models/transaksi.dart';
import 'package:pentagram/widgets/transaksi_card.dart';

class PengeluaranPage extends StatefulWidget {
  const PengeluaranPage({super.key});

  @override
  State<PengeluaranPage> createState() => _PengeluaranPageState();
}

class _PengeluaranPageState extends State<PengeluaranPage> {
  final List<Transaksi> _pengeluaranList = [
    Transaksi(
      id: '1',
      jenis: 'pengeluaran',
      keterangan: 'Belanja Bulanan',
      jumlah: 800000,
      tanggal: DateTime(2025, 10, 3),
    ),
    Transaksi(
      id: '2',
      jenis: 'pengeluaran',
      keterangan: 'Beli Pulsa',
      jumlah: 50000,
      tanggal: DateTime(2025, 10, 8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _pengeluaranList.length,
      itemBuilder: (context, index) {
        return TransaksiCard(transaksi: _pengeluaranList[index]);
      },
    );
  }
}
