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

  void _tambahPengeluaran() {
    final TextEditingController keteranganCtrl = TextEditingController();
    final TextEditingController jumlahCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tambah Pengeluaran"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keteranganCtrl,
              decoration: const InputDecoration(labelText: "Keterangan"),
            ),
            TextField(
              controller: jumlahCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Jumlah"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _pengeluaranList.add(Transaksi(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  jenis: 'pengeluaran',
                  keterangan: keteranganCtrl.text,
                  jumlah: double.tryParse(jumlahCtrl.text) ?? 0,
                  tanggal: DateTime.now(),
                ));
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengeluaran")),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahPengeluaran,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _pengeluaranList.length,
        itemBuilder: (context, index) {
          return TransaksiCard(transaksi: _pengeluaranList[index]);
        },
      ),
    );
  }
}
