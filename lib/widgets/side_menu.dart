// (Salin kode SideMenu dari jawaban sebelumnya)
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                "Jawara Pintar",
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
                DrawerListTile(title: "Dashboard", icon: Icons.dashboard, onTap: () {}),
                ExpansionTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text("Keuangan"),
                  children: <Widget>[
                    DrawerListTile(title: "Pemasukan", icon: Icons.arrow_downward, onTap: () {}, isSubMenu: true),
                    DrawerListTile(title: "Pengeluaran", icon: Icons.arrow_upward, onTap: () {}, isSubMenu: true),
                    DrawerListTile(title: "Laporan Keuangan", icon: Icons.receipt_long, onTap: () {}, isSubMenu: true),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.people),
                  title: const Text("Kependudukan"),
                  children: <Widget>[
                    DrawerListTile(title: "Data Warga & Rumah", icon: Icons.home_work, onTap: () {}, isSubMenu: true),
                     DrawerListTile(title: "Penerimaan Warga", icon: Icons.person_add, onTap: () {}, isSubMenu: true),
                     DrawerListTile(title: "Mutasi Keluarga", icon: Icons.transfer_within_a_station, onTap: () {}, isSubMenu: true),
                  ],
                ),
                DrawerListTile(title: "Kegiatan & Broadcast", icon: Icons.campaign, onTap: () {}),
                DrawerListTile(title: "Pesan Warga", icon: Icons.message, onTap: () {}),
                const Divider(),
                DrawerListTile(title: "Log Aktifitas", icon: Icons.history, onTap: () {}),
                DrawerListTile(title: "Manajemen Pengguna", icon: Icons.manage_accounts, onTap: () {}),
                DrawerListTile(title: "Channel Transfer", icon: Icons.sync_alt, onTap: () {}),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: const Text("Admin Jawara"),
            subtitle: const Text("admin@gmail.com"),
            trailing: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSubMenu = false,
  }) : super(key: key);

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