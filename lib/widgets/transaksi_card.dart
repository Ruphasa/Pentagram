import 'package:flutter/material.dart';
import 'package:pentagram/models/transaksi.dart';

class TransaksiCard extends StatelessWidget {
  final Transaksi transaksi;

  const TransaksiCard({super.key, required this.transaksi});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(transaksi.keterangan),
        subtitle: Text(
          "${transaksi.tanggal.day}-${transaksi.tanggal.month}-${transaksi.tanggal.year}",
        ),
        trailing: Text(
          'Rp ${transaksi.jumlah}',
          style: TextStyle(
            color: transaksi.jenis == 'pemasukan' ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
