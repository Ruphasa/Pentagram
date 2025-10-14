import 'package:flutter/material.dart';
import '../../responsive.dart';
import '../../widgets/side_menu.dart';

class DaftarMutasiPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DaftarMutasiPage({super.key});

  final List<Map<String, String>> dataMutasi = [
    {
      'no': '1',
      'tanggal': '30 September 2025',
      'keluarga': 'Keluarga Mara Nunez',
      'jenis': 'Pindah Rumah',
    },
    {
      'no': '2',
      'tanggal': '24 Oktober 2026',
      'keluarga': 'Keluarga Ijat',
      'jenis': 'Pindah Rumah',
    },
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
          "Daftar Mutasi Keluarga",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: !Responsive.isDesktop(context)
            ? IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              )
            : null,
      ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Daftar Mutasi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        icon: const Icon(Icons.filter_list, color: Colors.white),
                        label: const Text(
                          "Filter",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                // Table Header
                Container(
                  color: Colors.grey.shade100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: const Row(
                    children: [
                      Expanded(flex: 1, child: Text("NO")),
                      Expanded(flex: 3, child: Text("TANGGAL")),
                      Expanded(flex: 4, child: Text("KELUARGA")),
                      Expanded(flex: 3, child: Text("JENIS MUTASI")),
                      Expanded(flex: 1, child: Text("AKSI")),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // Table Rows
                ...dataMutasi.map(
                  (data) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text(data['no']!)),
                        Expanded(flex: 3, child: Text(data['tanggal']!)),
                        Expanded(flex: 4, child: Text(data['keluarga']!)),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Text(
                              data['jenis']!,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "1",
                          style: TextStyle(color: Colors.white),
                        ),
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
      backgroundColor: const Color(0xFFF4F7FB),
    );
  }
}
