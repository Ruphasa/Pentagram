import 'package:flutter/material.dart';

class FilterPesanDialog extends StatefulWidget {
  final void Function(String? judul, String? status) onFilter;

  const FilterPesanDialog({required this.onFilter, super.key});

  @override
  State<FilterPesanDialog> createState() => _FilterPesanDialogState();
}

class _FilterPesanDialogState extends State<FilterPesanDialog> {
  final TextEditingController _judulController = TextEditingController();
  String? status;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(top: 16, left: 20, right: 8, bottom: 0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Filter Pesan Warga',
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
            controller: _judulController,
            decoration: const InputDecoration(labelText: 'Judul'),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Status'),
            value: status,
            items: const [
              DropdownMenuItem(value: 'Pending', child: Text('Pending')),
              DropdownMenuItem(value: 'Diterima', child: Text('Diterima')),
              DropdownMenuItem(value: 'Ditolak', child: Text('Ditolak')),
            ],
            onChanged: (v) => setState(() => status = v),
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
              // Tombol Reset di kiri bawah
              TextButton(
                onPressed: () {
                  setState(() {
                    _judulController.clear();
                    status = null;
                  });
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Colors.black87),
                ),
              ),

              // Tombol Terapkan di kanan bawah
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
                  widget.onFilter(_judulController.text, status);
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
