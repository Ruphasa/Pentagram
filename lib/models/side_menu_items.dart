// Sidebar menu data as value-only maps to keep the widget lean.
// Top-level single items (non-expandable)
const List<Map<String, dynamic>> sideMenuTopItems = [
  {
    'title': 'Dashboard',
    'iconKey': 'dashboard',
    'action': 'dashboard',
    'route': '/dashboard',
  },
];

// Grouped sections (expandable). Items may have an 'action' string key
// that is resolved by the routes mapper.
const List<Map<String, dynamic>> sideMenuSections = [
  {
    'title': 'Data Warga & Rumah',
    'iconKey': 'people',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Warga - Daftar',
        'iconKey': 'list_alt',
        'action': 'warga-daftar',
        'route': '/warga/daftar',
      },
      {
        'title': 'Warga - Tambah',
        'iconKey': 'person_add',
        'action': 'warga-tambah',
        'route': '/warga/tambah',
      },
      {
        'title': 'Keluarga',
        'iconKey': 'family_restroom',
        'action': null,
        'route': null,
      },
      {
        'title': 'Rumah - Daftar',
        'iconKey': 'home_work',
        'action': null,
        'route': null,
      },
      {
        'title': 'Rumah - Tambah',
        'iconKey': 'add_home',
        'action': null,
        'route': null,
      },
    ],
  },
  {
    'title': 'Pemasukan',
    'iconKey': 'attach_money',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Daftar Pemasukan',
        'iconKey': 'arrow_downward',
        'action': 'pemasukan',
        'route': '/pemasukan',
      },
    ],
  },
  {
    'title': 'Pengeluaran',
    'iconKey': 'money_off',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Daftar Pengeluaran',
        'iconKey': 'arrow_upward',
        'action': 'pengeluaran',
        'route': '/pengeluaran',
      },
    ],
  },
  {
    'title': 'Laporan Keuangan',
    'iconKey': 'receipt_long',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Lihat Laporan',
        'iconKey': 'receipt_long',
        'action': null,
        'route': null,
      },
    ],
  },
  {
    'title': 'Kegiatan & Broadcast',
    'iconKey': 'campaign',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Daftar Kegiatan',
        'iconKey': 'event',
        'action': null,
        'route': null,
      },
    ],
  },
  {
    'title': 'Pesan Warga',
    'iconKey': 'message',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Kotak Masuk',
        'iconKey': 'inbox',
        'action': null,
        'route': null,
      },
    ],
  },
  {
    'title': 'Penerimaan Warga',
    'iconKey': 'person_add_alt',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Daftar Pendaftaran',
        'iconKey': 'list',
        'action': null,
        'route': null,
      },
    ],
  },
  {
    'title': 'Mutasi Keluarga',
    'iconKey': 'transfer_within_a_station',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Daftar',
        'iconKey': 'list_alt',
        'action': 'mutasi-daftar',
        'route': '/mutasi-keluarga/daftar',
      },
      {
        'title': 'Tambah',
        'iconKey': 'add',
        'action': 'mutasi-tambah',
        'route': '/mutasi-keluarga/tambah',
      }
    ],
  },
  {
    'title': 'Log Aktifitas',
    'iconKey': 'history',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Semua Aktivitas',
        'iconKey': 'history',
        'action': 'log-aktivitas',
        'route': '/log-aktivitas',
      }
    ],
  },
  {
    'title': 'Manajemen Pengguna',
    'iconKey': 'manage_accounts',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Daftar Pengguna',
        'iconKey': 'list',
        'action': 'pengguna-daftar',
        'route': '/manajemen-pengguna/daftar',
      },
      {
        'title': 'Tambah Pengguna',
        'iconKey': 'person_add',
        'action': 'pengguna-tambah',
        'route': '/manajemen-pengguna/tambah',
      },
    ],
  },
  {
    'title': 'Channel Transfer',
    'iconKey': 'sync_alt',
    'initiallyExpanded': false,
    'items': [
      {
        'title': 'Daftar Channel',
        'iconKey': 'list',
        'action': 'channel-daftar',
        'route': '/channel-transfer/daftar',
      },
      {
        'title': 'Tambah Channel',
        'iconKey': 'add',
        'action': 'channel-tambah',
        'route': '/channel-transfer/tambah',
      },
    ],
  },
];
