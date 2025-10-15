import 'package:flutter/material.dart';
import 'package:pentagram/page/mutasi_keluarga/daftar_page.dart';
import 'package:pentagram/page/mutasi_keluarga/tambah_page.dart';
import 'package:pentagram/page/manajemen_pengguna/daftar_pengguna.dart';
import 'package:pentagram/page/manajemen_pengguna/tambah_pengguna.dart';
import 'package:pentagram/page/channel_transfer/daftar_channel.dart';
import 'package:pentagram/page/channel_transfer/tambah_channel.dart';
import 'package:pentagram/widgets/profile_dropdown.dart';
import 'package:pentagram/page/log_aktivitas/log_aktivitas_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'Jawara Pintar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerListTile(
                  title: 'Dashboard',
                  icon: Icons.dashboard,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
                ExpansionTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text('Keuangan'),
                  children: [
                    DrawerListTile(
                      title: 'Pemasukan',
                      icon: Icons.arrow_downward,
                      onTap: () {},
                      isSubMenu: true,
                    ),
                    DrawerListTile(
                      title: 'Pengeluaran',
                      icon: Icons.arrow_upward,
                      onTap: () {},
                      isSubMenu: true,
                    ),
                    DrawerListTile(
                      title: 'Laporan Keuangan',
                      icon: Icons.receipt_long,
                      onTap: () {},
                      isSubMenu: true,
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Kependudukan'),
                  children: [
                    DrawerListTile(
                      title: 'Data Warga & Rumah',
                      icon: Icons.home_work,
                      onTap: () {},
                      isSubMenu: true,
                    ),
                    DrawerListTile(
                      title: 'Penerimaan Warga',
                      icon: Icons.person_add,
                      onTap: () {},
                      isSubMenu: true,
                    ),
                    // 🔹 Submenu Mutasi Keluarga
                    ExpansionTile(
                      leading: const Icon(Icons.transfer_within_a_station),
                      title: const Text('Mutasi Keluarga'),
                      children: [
                        DrawerListTile(
                          title: 'Daftar',
                          icon: Icons.list_alt,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DaftarMutasiPage();
                                },
                              ),
                            );
                          },
                          isSubMenu: true,
                        ),
                        DrawerListTile(
                          title: 'Tambah',
                          icon: Icons.add,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const TambahMutasiPage();
                                },
                              ),
                            );
                          },
                          isSubMenu: true,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.calendar_month),
                  title: const Text('Kegiatan & Broadcast'),
                  children: [
                    DrawerListTile(
                      title: 'Kegiatan - Daftar', 
                      icon: Icons.app_registration_rounded, 
                      isSubMenu: true,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/activity/view');
                      },
                    ),
                    DrawerListTile(
                      title: 'Kegiatan - Tambah', 
                      icon: Icons.plus_one, 
                      isSubMenu: true,
                      onTap: () {},
                    ),
                    DrawerListTile(
                      title: 'Broadcast - Daftar', 
                      icon: Icons.app_registration_rounded, 
                      isSubMenu: true,
                      onTap: () {},
                    ),
                    DrawerListTile(
                      title: 'Broadcast - Tambah', 
                      icon: Icons.plus_one, 
                      isSubMenu: true,
                      onTap: () {},
                    ),
                  ],
                ),
                DrawerListTile(
                  title: 'Pesan Warga',
                  icon: Icons.message,
                  onTap: () {},
                ),
                const Divider(),
                ExpansionTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Log Aktivitas'),
                  children: [
                    DrawerListTile(
                      title: 'Semua Aktivitas',
                      icon: Icons.history,
                      isSubMenu: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogAktivitasPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                ExpansionTile(
                  leading: const Icon(Icons.manage_accounts),
                  title: const Text('Manajemen Pengguna'),
                  children: [
                    DrawerListTile(
                      title: 'Daftar Pengguna',
                      icon: Icons.list,
                      isSubMenu: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DaftarPenggunaPage(),
                          ),
                        );
                      },
                    ),
                    DrawerListTile(
                      title: 'Tambah Pengguna',
                      icon: Icons.person_add,
                      isSubMenu: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TambahPenggunaPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.sync_alt),
                  title: const Text('Channel Transfer'),
                  children: [
                    DrawerListTile(
                      title: 'Daftar Channel',
                      icon: Icons.list,
                      isSubMenu: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DaftarChannelPage(),
                          ),
                        );
                      },
                    ),
                    DrawerListTile(
                      title: 'Tambah Channel',
                      icon: Icons.add,
                      isSubMenu: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TambahChannelPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          const ProfileDropdown(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
    this.isSubMenu = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSubMenu;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: isSubMenu ? const EdgeInsets.only(left: 48.0) : null,
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: const TextStyle(color: Colors.black87)),
      onTap: onTap,
    );
  }
}
