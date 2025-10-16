// Model untuk data warga
class Warga {
  final int no;
  final String nama;
  final String nik;
  final String keluarga;
  final String jenisKelamin;
  final String statusDomisili;
  final String statusHidup;

  Warga({
    required this.no,
    required this.nama,
    required this.nik,
    required this.keluarga,
    required this.jenisKelamin,
    required this.statusDomisili,
    required this.statusHidup,
  });
}

// Sample data list warga
final List<Warga> sampleWargaList = [
  Warga(
    no: 1,
    nama: 'Anti Micin',
    nik: '1234567890987654',
    keluarga: 'Keluarga Anti Micin',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 2,
    nama: 'varisky naldiba rimra',
    nik: '137111011030005',
    keluarga: 'Keluarga varisky naldiba rimra',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 3,
    nama: 'lalalulu',
    nik: '1234567890123456',
    keluarga: 'Keluarga Ijat',
    jenisKelamin: 'Perempuan',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 4,
    nama: 'Ijot',
    nik: '2025202520252025',
    keluarga: 'Keluarga Ijat',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 5,
    nama: 'Raudhil Firdaus Naufal',
    nik: '3201122501050002',
    keluarga: 'Keluarga Raudhil Firdaus Naufal',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 6,
    nama: 'Cukurukuk',
    nik: '1234567891234567',
    keluarga: 'Keluarga Habibte Ed Dien',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 7,
    nama: 'Mara Nunez',
    nik: '1234567890123456',
    keluarga: 'Keluarga Mara Nunez',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 8,
    nama: 'Habibte Ed Dien',
    nik: '2341123456756789',
    keluarga: 'Keluarga Habibte Ed Dien',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
];
