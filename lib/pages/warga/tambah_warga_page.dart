import 'package:flutter/material.dart';
import 'package:pentagram/widgets/tambah_warga_form.dart';
import 'package:pentagram/utils/app_colors.dart';

class TambahWargaPage extends StatefulWidget {
  const TambahWargaPage({super.key});

  @override
  State<TambahWargaPage> createState() => _TambahWargaPageState();
}

class _TambahWargaPageState extends State<TambahWargaPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();

  // Dropdown values
  String? _selectedKeluarga;
  String? _selectedJenisKelamin;
  String? _selectedAgama;
  String? _selectedGolonganDarah;
  String? _selectedPeranKeluarga;
  String? _selectedPendidikanTerakhir;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = 
            '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Logika submit akan ditambahkan nanti
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data warga berhasil ditambahkan!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Clear form
      _clearForm();
    }
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    _namaController.clear();
    _nikController.clear();
    _nomorTeleponController.clear();
    _tempatLahirController.clear();
    _tanggalLahirController.clear();
    setState(() {
      _selectedKeluarga = null;
      _selectedJenisKelamin = null;
      _selectedAgama = null;
      _selectedGolonganDarah = null;
      _selectedPeranKeluarga = null;
      _selectedPendidikanTerakhir = null;
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nikController.dispose();
    _nomorTeleponController.dispose();
    _tempatLahirController.dispose();
    _tanggalLahirController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        title: const Text('Tambah Warga'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Tambah Warga',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // Form
            TambahWargaForm(
              formKey: _formKey,
              namaController: _namaController,
              nikController: _nikController,
              nomorTeleponController: _nomorTeleponController,
              tempatLahirController: _tempatLahirController,
              tanggalLahirController: _tanggalLahirController,
              selectedKeluarga: _selectedKeluarga,
              selectedJenisKelamin: _selectedJenisKelamin,
              selectedAgama: _selectedAgama,
              selectedGolonganDarah: _selectedGolonganDarah,
              selectedPeranKeluarga: _selectedPeranKeluarga,
              selectedPendidikanTerakhir: _selectedPendidikanTerakhir,
              onKeluargaChanged: (value) => setState(() => _selectedKeluarga = value),
              onJenisKelaminChanged: (value) => setState(() => _selectedJenisKelamin = value),
              onAgamaChanged: (value) => setState(() => _selectedAgama = value),
              onGolonganDarahChanged: (value) => setState(() => _selectedGolonganDarah = value),
              onPeranKeluargaChanged: (value) => setState(() => _selectedPeranKeluarga = value),
              onPendidikanChanged: (value) => setState(() => _selectedPendidikanTerakhir = value),
              onSelectDate: () => _selectDate(context),
              onSubmit: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
