import 'package:flutter/material.dart';
import 'package:pentagram/pages/activity_broadcast/const/activity_const.dart';

class ActivityAdd extends StatefulWidget {
  const ActivityAdd({super.key});

  @override
  State<ActivityAdd> createState() => _ActivityAddState();
}

class _ActivityAddState extends State<ActivityAdd> {
  final _formKey = GlobalKey<FormState>();
  final _namaKegiatanController = TextEditingController();
  final _deskripsiController = TextEditingController();

  String? _selectedKategori;
  String? _selectedLokasi;
  String? _selectedPenanggungJawab;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _namaKegiatanController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Tambah Kegiatan Baru'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Informasi Kegiatan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Lengkapi form di bawah untuk menambahkan kegiatan baru',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),

              // Nama Kegiatan
              _buildTextField(
                controller: _namaKegiatanController,
                label: 'Nama Kegiatan',
                hint: 'Masukkan nama kegiatan',
                icon: Icons.event,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama kegiatan harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Kategori Kegiatan
              _buildDropdownField(
                value: _selectedKategori,
                label: 'Kategori Kegiatan',
                hint: 'Pilih kategori kegiatan',
                icon: Icons.category,
                items: ActivityConst.kategoriOptions,
                onChanged: (value) {
                  setState(() {
                    _selectedKategori = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori kegiatan harus dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tanggal
              _buildDateField(),
              const SizedBox(height: 16),

              // Lokasi
              _buildDropdownField(
                value: _selectedLokasi,
                label: 'Lokasi Kegiatan',
                hint: 'Pilih lokasi kegiatan',
                icon: Icons.location_on,
                items: ActivityConst.lokasiOptions,
                onChanged: (value) {
                  setState(() {
                    _selectedLokasi = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lokasi kegiatan harus dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Penanggung Jawab
              _buildDropdownField(
                value: _selectedPenanggungJawab,
                label: 'Penanggung Jawab',
                hint: 'Pilih penanggung jawab',
                icon: Icons.person,
                items: ActivityConst.penanggungJawabOptions,
                onChanged: (value) {
                  setState(() {
                    _selectedPenanggungJawab = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Penanggung jawab harus dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Deskripsi
              _buildTextField(
                controller: _deskripsiController,
                label: 'Deskripsi Kegiatan',
                hint: 'Masukkan deskripsi kegiatan',
                icon: Icons.description,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi kegiatan harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String label,
    required String hint,
    required IconData icon,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tanggal Pelaksanaan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey[600]),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Pilih tanggal pelaksanaan'
                        : _formatDate(_selectedDate!),
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedDate == null
                          ? Colors.grey[600]
                          : Colors.black87,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.blue),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      // Create activity data
      final activityData = {
        'nama': _namaKegiatanController.text.trim(),
        'kategori': _selectedKategori,
        'tanggal': _selectedDate!.toIso8601String(),
        'lokasi': _selectedLokasi,
        'penanggung_jawab': _selectedPenanggungJawab,
        'deskripsi': _deskripsiController.text.trim(),
      };

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kegiatan berhasil ditambahkan!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back
      Navigator.pop(context, activityData);
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal pelaksanaan harus dipilih!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
