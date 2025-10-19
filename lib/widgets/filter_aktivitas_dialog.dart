import 'package:flutter/material.dart';

class FilterAktivitasDialog extends StatefulWidget {
  final String initialDeskripsi;
  final String initialNamaPelaku;
  final DateTime? initialDariTanggal;
  final DateTime? initialSampaiTanggal;
  final Function(String, String, DateTime?, DateTime?) onApply;

  const FilterAktivitasDialog({
    required this.initialDeskripsi,
    required this.initialNamaPelaku,
    required this.onApply,
    super.key,
    this.initialDariTanggal,
    this.initialSampaiTanggal,
  });

  @override
  State<FilterAktivitasDialog> createState() => _FilterAktivitasDialogState();
}

class _FilterAktivitasDialogState extends State<FilterAktivitasDialog> {
  late TextEditingController deskripsiController;
  late TextEditingController namaPelakuController;
  DateTime? dariTanggal;
  DateTime? sampaiTanggal;

  @override
  void initState() {
    super.initState();
    deskripsiController = TextEditingController(text: widget.initialDeskripsi);
    namaPelakuController = TextEditingController(
      text: widget.initialNamaPelaku,
    );
    dariTanggal = widget.initialDariTanggal;
    sampaiTanggal = widget.initialSampaiTanggal;
  }

  Future<void> _selectDate(bool isDari) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isDari) {
          dariTanggal = picked;
        } else {
          sampaiTanggal = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 500,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter Aktivitas',
                    style: TextStyle(
                      color: Color(0xFF5A63B9),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildField(
                'Deskripsi',
                deskripsiController,
                hint: 'Cari deskripsi...',
              ),
              _buildField(
                'Nama Pelaku',
                namaPelakuController,
                hint: 'Contoh: Fafa',
              ),
              _buildDateField(
                'Dari Tanggal',
                dariTanggal,
                () => _selectDate(true),
              ),
              _buildDateField(
                'Sampai Tanggal',
                sampaiTanggal,
                () => _selectDate(false),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      deskripsiController.clear();
                      namaPelakuController.clear();
                      dariTanggal = null;
                      sampaiTanggal = null;
                      setState(() {});
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onApply(
                        deskripsiController.text,
                        namaPelakuController.text,
                        dariTanggal,
                        sampaiTanggal,
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A63B9),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                    ),
                    child: const Text('Terapkan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: AbsorbPointer(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '--/--/----',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.cyan,
                    size: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.cyan),
                  ),
                ),
                controller: TextEditingController(
                  text: date == null
                      ? ''
                      : '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}',
                ),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
