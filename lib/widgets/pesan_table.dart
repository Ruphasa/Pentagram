import 'package:flutter/material.dart';
import 'package:pentagram/models/pesan_warga.dart';

class TablePesanWarga extends StatelessWidget {
  final List<PesanWarga> data;
  final void Function(PesanWarga) onView;
  final void Function(PesanWarga) onEdit;
  final void Function(PesanWarga) onDelete;
  final int? currentPage;
  final int? totalPages;
  final Function(int)? onPageChanged;
  final bool? isMobile;

  const TablePesanWarga({
    required this.data,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    super.key,
    this.currentPage,
    this.totalPages,
    this.onPageChanged,
    this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobileView =
        isMobile ?? MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    columnSpacing: isMobileView ? 25 : 50,
                    headingRowColor: WidgetStateProperty.all(
                      const Color(0xFFEFF1FF),
                    ),
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.grey.shade200),
                    ),
                    columns: const [
                      DataColumn(label: Text('NO', style: _headerStyle)),
                      DataColumn(label: Text('PENGIRIM', style: _headerStyle)),
                      DataColumn(label: Text('JUDUL', style: _headerStyle)),
                      DataColumn(label: Text('STATUS', style: _headerStyle)),
                      DataColumn(
                        label: Text('TANGGAL DIBUAT', style: _headerStyle),
                      ),
                      DataColumn(label: Text('AKSI', style: _headerStyle)),
                    ],
                    rows: data.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final pesan = entry.value;

                      return DataRow(
                        color: WidgetStateProperty.resolveWith<Color?>(
                          (states) => index.isEven
                              ? Colors.grey.shade50
                              : Colors.transparent,
                        ),
                        cells: [
                          DataCell(
                            SizedBox(
                              width: 40,
                              child: Text(
                                '$index',
                                style: _cellText(isMobile: isMobileView),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              pesan.pengirim,
                              style: _cellText(isMobile: isMobileView),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            Text(
                              pesan.judul,
                              style: _cellText(isMobile: isMobileView),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(_buildStatus(pesan.status, isMobileView)),
                          DataCell(
                            SizedBox(
                              width: isMobileView ? 150 : 200,
                              child: Text(
                                _formatDate(pesan.tanggalDibuat),
                                style: _cellText(isMobile: isMobileView),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                          DataCell(
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert, size: 18),
                              onSelected: (value) {
                                if (value == 'view') onView(pesan);
                                if (value == 'edit') onEdit(pesan);
                                if (value == 'delete') onDelete(pesan);
                              },
                              itemBuilder: (_) => const [
                                PopupMenuItem(
                                  value: 'view',
                                  child: Text('Detail'),
                                ),
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Hapus'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          // === Pagination disamakan dengan AktivitasTable ===
          if (currentPage != null &&
              totalPages != null &&
              onPageChanged != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: currentPage! > 1
                        ? () => onPageChanged!(currentPage! - 1)
                        : null,
                    icon: const Icon(Icons.chevron_left, color: Colors.black54),
                  ),
                  for (int i = 1; i <= 3; i++) _buildPageButton(i),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('...', style: TextStyle(color: Colors.black54)),
                  ),
                  _buildPageButton(totalPages!),
                  IconButton(
                    onPressed: currentPage! < totalPages!
                        ? () => onPageChanged!(currentPage! + 1)
                        : null,
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xFF5A63B9),
    fontSize: 12,
  );

  TextStyle _cellText({bool isMobile = false}) =>
      TextStyle(fontSize: isMobile ? 11 : 13, color: Colors.black87);

  Widget _buildStatus(String status, bool isMobile) {
    Color color;
    Color textColor;
    switch (status) {
      case 'Diterima':
        color = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'Ditolak':
        color = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case 'Pending':
        color = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      default:
        color = Colors.grey.shade200;
        textColor = Colors.black54;
    }

    return SizedBox(
      width: 140, // Kolom status lebih lebar dari sebelumnya
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: TextStyle(color: textColor, fontSize: isMobile ? 10 : 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildPageButton(int page) {
    final isActive = page == currentPage;
    return InkWell(
      onTap: () => onPageChanged!(page),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF5A63B9) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF5A63B9)),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF5A63B9),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_bulan(date.month)} ${date.year}';
  }

  String _bulan(int bulan) {
    const list = [
      '',
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
    return list[bulan];
  }
}
