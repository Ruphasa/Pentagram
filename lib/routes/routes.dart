import 'package:flutter/material.dart';
import 'package:pentagram/page/dashboard.dart';
import 'package:pentagram/page/keuangan/pemasukan_page.dart';
import 'package:pentagram/page/keuangan/pengeluaran_page.dart';
import 'package:pentagram/page/warga/daftar_warga_page.dart';
import 'package:pentagram/page/warga/tambah_warga_page.dart';
import 'package:pentagram/page/mutasi_keluarga/daftar_page.dart' as mutasi;
import 'package:pentagram/page/mutasi_keluarga/tambah_page.dart' as mutasi;
import 'package:pentagram/page/manajemen_pengguna/daftar_pengguna.dart' as pengguna;
import 'package:pentagram/page/manajemen_pengguna/tambah_pengguna.dart' as pengguna;
import 'package:pentagram/page/channel_transfer/daftar_channel.dart' as channel;
import 'package:pentagram/page/channel_transfer/tambah_channel.dart' as channel;
import 'package:pentagram/page/log_aktivitas/log_aktivitas_page.dart' as logx;

WidgetBuilder? builderFromAction(String? action) {
  switch (action) {
    case 'dashboard':
      return (_) => const DashboardScreen();
    case 'warga-daftar':
      return (_) => const DaftarWargaPage();
    case 'warga-tambah':
      return (_) => const TambahWargaPage();
    case 'mutasi-daftar':
      return (_) => mutasi.DaftarMutasiPage();
    case 'mutasi-tambah':
      return (_) => const mutasi.TambahMutasiPage();
    case 'log-aktivitas':
      return (_) => const logx.LogAktivitasPage();
    case 'pengguna-daftar':
      return (_) => pengguna.DaftarPenggunaPage();
    case 'pengguna-tambah':
      return (_) => pengguna.TambahPenggunaPage();
    case 'channel-daftar':
      return (_) => channel.DaftarChannelPage();
    case 'channel-tambah':
      return (_) => const channel.TambahChannelPage();
    case 'pemasukan':
      return (_) => const PemasukanPage();
    case 'pengeluaran':
      return (_) => const PengeluaranPage();
    default:
      return null;
  }
}

// Helper to get route name from action key
String? routeFromAction(String? action) {
  switch (action) {
    case 'dashboard':
      return '/dashboard';
    case 'warga-daftar':
      return '/warga/daftar';
    case 'warga-tambah':
      return '/warga/tambah';
    case 'mutasi-daftar':
      return '/mutasi-keluarga/daftar';
    case 'mutasi-tambah':
      return '/mutasi-keluarga/tambah';
    case 'log-aktivitas':
      return '/log-aktivitas';
    case 'pengguna-daftar':
      return '/manajemen-pengguna/daftar';
    case 'pengguna-tambah':
      return '/manajemen-pengguna/tambah';
    case 'channel-daftar':
      return '/channel-transfer/daftar';
    case 'channel-tambah':
      return '/channel-transfer/tambah';
    case 'pemasukan':
      return '/pemasukan';
    case 'pengeluaran':
      return '/pengeluaran';
    default:
      return null;
  }
}
