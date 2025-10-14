import 'package:flutter/material.dart';
import '../../responsive.dart';
import '../../widgets/side_menu.dart';

class DaftarPenggunaPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DaftarPenggunaPage({super.key});

  final List<Map<String, String>> dataPengguna = [
    {'no': '1', 'nama': 'bla', 'email': 'y@gmail.com', 'status': 'Diterima'},
    {'no': '2', 'nama': 'ijat4', 'email': 'ijat4@gmail.com', 'status': 'Diterima'},
    {'no': '3', 'nama': 'ijat3', 'email': 'ijat3@gmail.com', 'status': 'Diterima'},
    {'no': '4', 'nama': 'ijat2', 'email': 'ijat2@gmail.com', 'status': 'Diterima'},
    {'no': '5', 'nama': 'ijat', 'email': 'ijat1@gmail.com', 'status': 'Diterima'},
    {'no': '6', 'nama': 'AFIFAH KHOIRUNNISA', 'email': 'afi@gmail.com', 'status': 'Diterima'},
    {'no': '7', 'nama': 'Raudhli Firdaus Naufal', 'email': 'raudhlifirdausn@gmail.com', 'status': 'Diterima'},
    {'no': '8', 'nama': 'ASDOPAR', 'email': 'ASDOPAR@GMAIL.COM', 'status': 'Diterima'},
    {'no': '9', 'nama': 'FAJRUL', 'email': 'FAJRUL10@gmail.com', 'status': 'Diterima'},
    {'no': '10', 'nama': 'Mara Nunez', 'email': 'tecug@mailinator.com', 'status': 'Diterima'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Daftar Pengguna",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: !Responsive.isDesktop(context)
            ? IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              )
            : null,
      ),
      backgroundColor: const Color(0xFFF4F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header Table dan Filter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Daftar Pengguna",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        icon: const Icon(Icons.filter_list, color: Colors.white),
                        label: const Text("Filter", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),

                // Table Header
                Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: const Row(
                    children: [
                      Expanded(flex: 1, child: Text("NO")),
                      Expanded(flex: 3, child: Text("NAMA")),
                      Expanded(flex: 4, child: Text("EMAIL")),
                      Expanded(flex: 3, child: Text("STATUS REGISTRASI")),
                      Expanded(flex: 1, child: Text("AKSI")),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // Table Rows
                ...dataPengguna.map(
                  (data) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: int.parse(data['no']!) % 2 == 0
                          ? Colors.grey.shade50
                          : Colors.white,
                      border: const Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text(data['no']!)),
                        Expanded(flex: 3, child: Text(data['nama']!)),
                        Expanded(flex: 4, child: Text(data['email']!)),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: Text(
                              data['status']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Icon(Icons.more_vert, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),

                // Pagination
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_left),
                        color: Colors.grey,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "1",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text("2"),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_right),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
