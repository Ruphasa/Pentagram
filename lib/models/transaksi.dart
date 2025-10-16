class Transaksi {
  final String id;
  final String keterangan;
  final DateTime tanggal;
  final double jumlah;
  final String jenis; // 'pemasukan' atau 'pengeluaran'

  Transaksi({
    required this.id,
    required this.keterangan,
    required this.tanggal,
    required this.jumlah,
    required this.jenis,
  });
}
