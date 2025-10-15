import 'package:flutter/material.dart';

class AktivitasTable extends StatelessWidget {
  final List<Map<String, dynamic>> aktivitasData;
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final bool isMobile;

  const AktivitasTable({
    required this.aktivitasData, required this.currentPage, required this.totalPages, required this.onPageChanged, super.key,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  child: Text('NO', style: _headerStyle(), textAlign: TextAlign.center),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: Text('DESKRIPSI', style: _headerStyle()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Text('AKTOR', style: _headerStyle()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Text('TANGGAL', style: _headerStyle()),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF2A2A2A), height: 1),

          // Data
          Expanded(
            child: ListView.builder(
              itemCount: aktivitasData.length,
              itemBuilder: (context, index) {
                final item = aktivitasData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 32,
                        child: Text(
                          '${item['no']}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: Text(
                          item['deskripsi'],
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: Text(
                          item['aktor'],
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: Text(
                          item['tanggal'],
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Pagination
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFF2A2A2A))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: currentPage > 1
                      ? () => onPageChanged(currentPage - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left, color: Colors.white70),
                ),
                for (int i = 1; i <= 3; i++) _buildPageButton(i),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('...', style: TextStyle(color: Colors.white70)),
                ),
                _buildPageButton(totalPages),
                IconButton(
                  onPressed: currentPage < totalPages
                      ? () => onPageChanged(currentPage + 1)
                      : null,
                  icon: const Icon(Icons.chevron_right, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton(int page) {
    final isActive = page == currentPage;
    return InkWell(
      onTap: () => onPageChanged(page),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.cyan : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white70,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  TextStyle _headerStyle() => const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      );
}
