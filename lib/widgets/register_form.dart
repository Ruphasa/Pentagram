import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nikController = TextEditingController();
  final _emailController = TextEditingController();
  final _telpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _alamatController = TextEditingController();

  String? _jenisKelamin;
  String? _rumah;
  String? _statusRumah;
  bool _isHoveringButton = false;
  bool _isHoveringLogin = false;

  final List<String> _listJenisKelamin = ['Laki-laki', 'Perempuan'];
  final List<String> _listRumah = [
    'i',
    'Quis',
    'Fasda',
    'wer wer',
    'Jl. Merbabu',
  ];
  final List<String> _listStatusRumah = ['Pemilik', 'Penyewa'];

  @override
  Widget build(BuildContext context) {
    const secondaryColor = Color(0xFF5a63b9);

    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Akun',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lengkapi formulir untuk membuat akun.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 32),
            _buildTextField('Nama Lengkap', _namaController),
            _buildTextField('NIK', _nikController),
            _buildTextField('Email', _emailController),
            _buildTextField(
              'No Telepon',
              _telpController,
              hint: '08xxxxxxxxxx',
            ),
            _buildTextField('Password', _passwordController, obscure: true),
            _buildTextField(
              'Konfirmasi Password',
              _confirmPasswordController,
              obscure: true,
            ),
            _buildDropdown(
              label: 'Jenis Kelamin',
              hint: '-- Pilih Jenis Kelamin --',
              value: _jenisKelamin,
              items: _listJenisKelamin,
              onChanged: (v) => setState(() => _jenisKelamin = v),
            ),
            _buildDropdown(
              label: 'Pilih Rumah yang Sudah Ada',
              hint: '-- Pilih Rumah --',
              value: _rumah,
              items: _listRumah,
              onChanged: (v) {
                setState(() {
                  _rumah = v;
                  if (v != null && v.isNotEmpty) {
                    _alamatController.clear();
                  }
                });
              },
            ),
            const Text(
              'Kalau tidak ada di daftar, isi alamat rumah di bawah ini',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 6),
            _buildTextField(
              'Alamat Rumah (Jika Tidak Ada di List)',
              _alamatController,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  setState(() => _rumah = null);
                }
              },
            ),
            _buildDropdown(
              label: 'Status Kepemilikan Rumah',
              hint: '-- Pilih Status --',
              value: _statusRumah,
              items: _listStatusRumah,
              onChanged: (v) => setState(() => _statusRumah = v),
            ),
            const SizedBox(height: 16),
            _buildUploadField(),
            const SizedBox(height: 32),
            _buildRegisterButton(),
            const SizedBox(height: 20),
            _buildLoginLink(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    String? hint,
    Function(String)? onChanged,
  }) {
    const secondaryColor = Color(0xFF5a63b9);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: obscure,
            onChanged: onChanged,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              hintText: hint ?? 'Masukkan $label di sini',
              hintStyle: const TextStyle(color: Colors.black38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black26, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black26, width: 1.5),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    const secondaryColor = Color(0xFF5a63b9);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            hint: Text(hint, style: const TextStyle(color: Colors.black45)),
            isExpanded: true,
            items: items
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black26, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black26, width: 1.5),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 2),
              ),
            ),
            iconEnabledColor: secondaryColor,
            dropdownColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildUploadField() {
    return Container(
      height: 80,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: const Text(
        'Upload foto KK/KTP (.png/.jpg)',
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  Widget _buildRegisterButton() {
    const secondaryColor = Color(0xFF5a63b9);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHoveringButton = true),
      onExit: (_) => setState(() => _isHoveringButton = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHoveringButton ? 1.02 : 1.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Akun berhasil dibuat'),
                  backgroundColor: Color(0xFF6b82ee),
                ),
              );
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: _isHoveringButton ? 8 : 2,
            ),
            child: const Text(
              'Buat Akun',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    const secondaryColor = Color(0xFF5a63b9);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sudah punya akun? ',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        MouseRegion(
          onEnter: (_) => setState(() => _isHoveringLogin = true),
          onExit: (_) => setState(() => _isHoveringLogin = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            child: Text(
              'Masuk',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: secondaryColor,
                decoration: _isHoveringLogin
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationColor: secondaryColor,
                decorationThickness: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
