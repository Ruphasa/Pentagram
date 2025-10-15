import 'package:flutter/material.dart';
import 'package:pentagram/models/transaksi.dart';
import 'package:pentagram/widgets/transaksi_card.dart';

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

  void _tambahPemasukan() {
    final TextEditingController keteranganCtrl = TextEditingController();
    final TextEditingController jumlahCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tambah Pemasukan"),
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
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pemasukan")),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahPemasukan,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _pemasukanList.length,
        itemBuilder: (context, index) {
          return TransaksiCard(transaksi: _pemasukanList[index]);
        },
      ),
    );
  }
}
