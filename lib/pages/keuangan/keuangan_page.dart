import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/widgets/common_header.dart';
import 'package:intl/intl.dart';

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({super.key});

  @override
  State<KeuanganPage> createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage> {
  bool showIncome = true;

  List<Map<String, dynamic>> incomeList = [
    {'title': 'Iuran Bulanan', 'date': DateTime(2025, 10, 21), 'amount': 2500000},
    {'title': 'Donasi Kegiatan', 'date': DateTime(2025, 10, 20), 'amount': 1000000},
    {'title': 'Sumbangan Warga', 'date': DateTime(2025, 10, 19), 'amount': 500000},
  ];

  List<Map<String, dynamic>> expenseList = [
    {'title': 'Belanja Kegiatan', 'date': DateTime(2025, 10, 21), 'amount': 1200000},
    {'title': 'Konsumsi Rapat', 'date': DateTime(2025, 10, 20), 'amount': 300000},
    {'title': 'Perawatan Fasilitas', 'date': DateTime(2025, 10, 18), 'amount': 800000},
  ];

  String _formatDate(DateTime date) {
    final months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  int _calculateTotal(List<Map<String, dynamic>> list) {
    return list.fold(0, (sum, item) => sum + (item['amount'] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const CommonHeader(title: 'Keuangan'),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildTopSummary(),
                  const SizedBox(height: 24),
                  _buildFilterToggle(),
                  const SizedBox(height: 16),
                  ..._buildTransactionList(),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, color: AppColors.textOnPrimary),
        onPressed: () => _showAddTransactionForm(context),
      ),
    );
  }

  Widget _buildTopSummary() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            title: 'Pemasukan',
            amount: _formatCurrency(_calculateTotal(incomeList)),
            icon: Icons.arrow_downward_rounded,
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            title: 'Pengeluaran',
            amount: _formatCurrency(_calculateTotal(expenseList)),
            icon: Icons.arrow_upward_rounded,
            color: AppColors.error,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterButton(
              label: 'Pemasukan',
              isSelected: showIncome,
              onTap: () => setState(() => showIncome = true),
            ),
          ),
          Expanded(
            child: _buildFilterButton(
              label: 'Pengeluaran',
              isSelected: !showIncome,
              onTap: () => setState(() => showIncome = false),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTransactionList() {
    final data = showIncome ? incomeList : expenseList;
    // Sort by date descending
    final sortedData = List<Map<String, dynamic>>.from(data)
      ..sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));
    
    return sortedData
        .map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildTransactionItem(
                title: item['title'] as String,
                date: item['date'] as DateTime,
                amount: item['amount'] as int,
                isIncome: showIncome,
              ),
            ))
        .toList();
  }

  // Form Tambah Transaksi
  void _showAddTransactionForm(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    showIncome ? 'Tambah Pemasukan' : 'Tambah Pengeluaran',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(titleController, 'Judul'),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setModalState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDate(selectedDate),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInputField(amountController, 'Jumlah (tanpa titik/koma)', isNumber: true),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      onPressed: () {
                        if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                          final amount = int.tryParse(amountController.text);
                          if (amount != null) {
                            setState(() {
                              final newData = {
                                'title': titleController.text,
                                'date': selectedDate,
                                'amount': amount,
                              };
                              showIncome ? incomeList.add(newData) : expenseList.add(newData);
                            });
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Text('Simpan', style: TextStyle(color: AppColors.textOnPrimary)),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Widget Helper
  Widget _buildInputField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildSummaryCard({required String title, required String amount, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: Offset(0, 2))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 12),
        Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
      ]),
    );
  }

  Widget _buildFilterButton({required String label, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.background : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected ? [const BoxShadow(color: AppColors.shadow, blurRadius: 4, offset: Offset(0, 2))] : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem({required String title, required DateTime date, required int amount, required bool isIncome}) {
    final icon = isIncome ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
    final color = isIncome ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(_formatDate(date), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(_formatCurrency(amount), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}