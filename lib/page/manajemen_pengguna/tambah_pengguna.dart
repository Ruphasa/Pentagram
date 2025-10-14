import 'package:flutter/material.dart';
import '../../responsive.dart';
import '../../widgets/side_menu.dart';

class TambahPenggunaPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TambahPenggunaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Tambah Akun Pengguna",
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu samping untuk layar besar
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),

            // Konten utama
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tambah Akun Pengguna",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Nama Lengkap
                      buildTextField("Nama Lengkap", "Masukkan nama lengkap"),

                      // Email
                      buildTextField("Email", "Masukkan email aktif"),

                      // Nomor HP
                      buildTextField(
                        "Nomor HP",
                        "Masukkan nomor HP (cth: 08xxxxxxxxxx)",
                      ),

                      // Password
                      buildTextField("Password", "Masukkan password",
                          obscureText: true),

                      // Konfirmasi Password
                      buildTextField(
                        "Konfirmasi Password",
                        "Masukkan ulang password",
                        obscureText: true,
                      ),

                      // Role Dropdown
                      const SizedBox(height: 16),
                      const Text(
                        "Role",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          hint: const Text("-- Pilih Role --"),
                          items: const [
                            DropdownMenuItem(
                              value: "Admin",
                              child: Text("Admin"),
                            ),
                            DropdownMenuItem(
                              value: "Ketua RW",
                              child: Text("Ketua RW"),
                            ),
                            DropdownMenuItem(
                              value: "Ketua RT",
                              child: Text("Ketua RT"),
                            ),
                            DropdownMenuItem(
                              value: "Sekretaris",
                              child: Text("Sekretaris"),
                            ),
                            DropdownMenuItem(
                              value: "Bendahara",
                              child: Text("Bendahara"),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Tombol Aksi
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              "Simpan",
                              style: TextStyle(color: Colors.white), // teks putih
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              foregroundColor: Colors.grey, // teks grey
                              side: const BorderSide(color: Colors.grey),
                            ),
                            child: const Text(
                              "Reset",
                              style: TextStyle(color: Colors.grey), // teks grey
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi bantu untuk membuat text field
  Widget buildTextField(String label, String hint,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
