import 'package:flutter/material.dart';

class FilterAktivitasDialog extends StatefulWidget {
  final String? initialDeskripsi;
  final String? initialNamaPelaku;
  final DateTime? initialDariTanggal;
  final DateTime? initialSampaiTanggal;
  final void Function(String deskripsi, String namaPelaku, DateTime? dari, DateTime? sampai) onApply;

  const FilterAktivitasDialog({
    required this.onApply, super.key,
    this.initialDeskripsi,
    this.initialNamaPelaku,
    this.initialDariTanggal,
    this.initialSampaiTanggal,
  });

  @override
  State<FilterAktivitasDialog> createState() => _FilterAktivitasDialogState();
}

class _FilterAktivitasDialogState extends State<FilterAktivitasDialog> {
  late TextEditingController _deskripsiController;
  late TextEditingController _namaPelakuController;
  DateTime? _dariTanggal;
  DateTime? _sampaiTanggal;

  @override
  void initState() {
    super.initState();
    _deskripsiController = TextEditingController(text: widget.initialDeskripsi ?? '');
    _namaPelakuController = TextEditingController(text: widget.initialNamaPelaku ?? '');
    _dariTanggal = widget.initialDariTanggal;
    _sampaiTanggal = widget.initialSampaiTanggal;
  }

  Future<void> _pilihTanggal(BuildContext context, bool isDari) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        if (isDari) {
          _dariTanggal = picked;
        } else {
          _sampaiTanggal = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(top: 16, left: 20, right: 8, bottom: 0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Filter Aktivitas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF5A63B9),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Tutup',
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _deskripsiController,
            decoration: const InputDecoration(labelText: 'Deskripsi Aktivitas'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _namaPelakuController,
            decoration: const InputDecoration(labelText: 'Nama Pelaku'),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _pilihTanggal(context, true),
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Dari Tanggal'),
                    child: Text(
                      _dariTanggal == null
                          ? '-'
                          : '${_dariTanggal!.day}/${_dariTanggal!.month}/${_dariTanggal!.year}',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () => _pilihTanggal(context, false),
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Sampai Tanggal'),
                    child: Text(
                      _sampaiTanggal == null
                          ? '-'
                          : '${_sampaiTanggal!.day}/${_sampaiTanggal!.month}/${_sampaiTanggal!.year}',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tombol Reset (pojok kiri)
              TextButton(
                onPressed: () {
                  setState(() {
                    _deskripsiController.clear();
                    _namaPelakuController.clear();
                    _dariTanggal = null;
                    _sampaiTanggal = null;
                  });
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Colors.black87),
                ),
              ),

              // Tombol Terapkan (pojok kanan)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A63B9),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  widget.onApply(
                    _deskripsiController.text,
                    _namaPelakuController.text,
                    _dariTanggal,
                    _sampaiTanggal,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Terapkan'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
