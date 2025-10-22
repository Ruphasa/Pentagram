import 'package:flutter/material.dart';
import 'package:pentagram/models/warga_form_data.dart';
import 'package:pentagram/widgets/form_label.dart';
import 'package:pentagram/widgets/custom_text_field.dart';
import 'package:pentagram/widgets/custom_date_field.dart';
import 'package:pentagram/widgets/custom_dropdown.dart';
import 'package:pentagram/utils/app_colors.dart';

class TambahWargaForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController namaController;
  final TextEditingController nikController;
  final TextEditingController nomorTeleponController;
  final TextEditingController tempatLahirController;
  final TextEditingController tanggalLahirController;
  final String? selectedKeluarga;
  final String? selectedJenisKelamin;
  final String? selectedAgama;
  final String? selectedGolonganDarah;
  final String? selectedPeranKeluarga;
  final String? selectedPendidikanTerakhir;
  final Function(String?) onKeluargaChanged;
  final Function(String?) onJenisKelaminChanged;
  final Function(String?) onAgamaChanged;
  final Function(String?) onGolonganDarahChanged;
  final Function(String?) onPeranKeluargaChanged;
  final Function(String?) onPendidikanChanged;
  final VoidCallback onSelectDate;
  final VoidCallback onSubmit;

  const TambahWargaForm({
    super.key,
    required this.formKey,
    required this.namaController,
    required this.nikController,
    required this.nomorTeleponController,
    required this.tempatLahirController,
    required this.tanggalLahirController,
    required this.selectedKeluarga,
    required this.selectedJenisKelamin,
    required this.selectedAgama,
    required this.selectedGolonganDarah,
    required this.selectedPeranKeluarga,
    required this.selectedPendidikanTerakhir,
    required this.onKeluargaChanged,
    required this.onJenisKelaminChanged,
    required this.onAgamaChanged,
    required this.onGolonganDarahChanged,
    required this.onPeranKeluargaChanged,
    required this.onPendidikanChanged,
    required this.onSelectDate,
    required this.onSubmit,
  });

  @override
  State<TambahWargaForm> createState() => _TambahWargaFormState();
}

class _TambahWargaFormState extends State<TambahWargaForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pilih Keluarga
            const FormLabel('Pilih Keluarga'),
            const SizedBox(height: 8),
            CustomDropdown(
              value: widget.selectedKeluarga,
              hint: '-- Pilih Keluarga --',
              items: WargaFormData.keluargaList,
              onChanged: widget.onKeluargaChanged,
            ),
            const SizedBox(height: 20),

            // Nama
            const FormLabel('Nama'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: widget.namaController,
              hint: 'Masukkan nama lengkap',
            ),
            const SizedBox(height: 20),

            // NIK
            const FormLabel('NIK'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: widget.nikController,
              hint: 'Masukkan NIK sesuai KTP',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Nomor Telepon
            const FormLabel('Nomor Telepon'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: widget.nomorTeleponController,
              hint: '08xxxxxx',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),

            // Tempat Lahir
            const FormLabel('Tempat Lahir'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: widget.tempatLahirController,
              hint: 'Masukkan tempat lahir',
            ),
            const SizedBox(height: 20),

            // Tanggal Lahir
            const FormLabel('Tanggal Lahir'),
            const SizedBox(height: 8),
            CustomDateField(
              controller: widget.tanggalLahirController,
              hint: '--/--/----',
              onTap: widget.onSelectDate,
            ),
            const SizedBox(height: 20),

            // Jenis Kelamin
            const FormLabel('Jenis Kelamin'),
            const SizedBox(height: 8),
            CustomDropdown(
              value: widget.selectedJenisKelamin,
              hint: '-- Pilih Jenis Kelamin --',
              items: WargaFormData.jenisKelaminList,
              onChanged: widget.onJenisKelaminChanged,
            ),
            const SizedBox(height: 20),

            // Agama
            const FormLabel('Agama'),
            const SizedBox(height: 8),
            CustomDropdown(
              value: widget.selectedAgama,
              hint: '-- Pilih Agama --',
              items: WargaFormData.agamaList,
              onChanged: widget.onAgamaChanged,
            ),
            const SizedBox(height: 20),

            // Golongan Darah
            const FormLabel('Golongan Darah'),
            const SizedBox(height: 8),
            CustomDropdown(
              value: widget.selectedGolonganDarah,
              hint: '-- Pilih Golongan Darah --',
              items: WargaFormData.golonganDarahList,
              onChanged: widget.onGolonganDarahChanged,
            ),
            const SizedBox(height: 20),

            // Peran Keluarga
            const FormLabel('Peran Keluarga'),
            const SizedBox(height: 8),
            CustomDropdown(
              value: widget.selectedPeranKeluarga,
              hint: '-- Pilih Peran Keluarga --',
              items: WargaFormData.peranKeluargaList,
              onChanged: widget.onPeranKeluargaChanged,
            ),
            const SizedBox(height: 20),

            // Pendidikan Terakhir
            const FormLabel('Pendidikan Terakhir'),
            const SizedBox(height: 8),
            CustomDropdown(
              value: widget.selectedPendidikanTerakhir,
              hint: '-- Pilih Pendidikan Terakhir --',
              items: WargaFormData.pendidikanList,
              onChanged: widget.onPendidikanChanged,
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  onPressed: widget.onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Tambah Warga',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
