import 'package:flutter/material.dart';
import 'package:pentagram/models/transaction.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/widgets/common/common_header.dart';
import 'package:pentagram/widgets/keuangan/finance_summary_card.dart';
import 'package:pentagram/widgets/keuangan/finance_filter_toggle.dart';
import 'package:pentagram/widgets/keuangan/transaction_item_card.dart';
import 'package:pentagram/widgets/keuangan/add_transaction_form.dart';
import 'package:pentagram/pages/keuangan/cetak_laporan_page.dart';
import 'package:intl/intl.dart';

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({super.key});

  @override
  State<KeuanganPage> createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage> {
  bool _showIncome = true;

  final List<Transaction> _incomeList = [
    Transaction(title: 'Iuran Bulanan', date: DateTime(2025, 10, 21), amount: 2500000, isIncome: true),
    Transaction(title: 'Donasi Kegiatan', date: DateTime(2025, 10, 20), amount: 1000000, isIncome: true),
    Transaction(title: 'Sumbangan Warga', date: DateTime(2025, 10, 19), amount: 500000, isIncome: true),
  ];

  final List<Transaction> _expenseList = [
    Transaction(title: 'Belanja Kegiatan', date: DateTime(2025, 10, 21), amount: 1200000, isIncome: false),
    Transaction(title: 'Konsumsi Rapat', date: DateTime(2025, 10, 20), amount: 300000, isIncome: false),
    Transaction(title: 'Perawatan Fasilitas', date: DateTime(2025, 10, 18), amount: 800000, isIncome: false),
  ];

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  int _calculateTotal(List<Transaction> list) {
    return list.fold(0, (sum, item) => sum + item.amount);
  }

  List<Transaction> get _currentList => _showIncome ? _incomeList : _expenseList;

  void _addTransaction(Transaction transaction) {
    setState(() {
      if (transaction.isIncome) {
        _incomeList.add(transaction);
      } else {
        _expenseList.add(transaction);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonHeader(
              title: 'Keuangan',
              actions: [
                IconButton(
                  icon: const Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CetakLaporanPage(),
                      ),
                    );
                  },
                  tooltip: 'Cetak Laporan',
                ),
              ],
            ),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: Icon(
          _showIncome ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
          color: AppColors.textOnPrimary,
        ),
        label: Text(
          _showIncome ? 'Tambah Pemasukan' : 'Tambah Pengeluaran',
          style: const TextStyle(color: AppColors.textOnPrimary),
        ),
        onPressed: () => _showAddTransactionForm(context),
      ),
    );
  }

  Widget _buildTopSummary() {
    return Row(
      children: [
        Expanded(
          child: FinanceSummaryCard(
            title: 'Pemasukan',
            amount: _formatCurrency(_calculateTotal(_incomeList)),
            icon: Icons.arrow_downward_rounded,
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FinanceSummaryCard(
            title: 'Pengeluaran',
            amount: _formatCurrency(_calculateTotal(_expenseList)),
            icon: Icons.arrow_upward_rounded,
            color: AppColors.error,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterToggle() {
    return FinanceFilterToggle(
      showIncome: _showIncome,
      onChanged: (value) => setState(() => _showIncome = value),
    );
  }

  List<Widget> _buildTransactionList() {
    final data = _currentList;
    // Sort by date descending
    final sortedData = List<Transaction>.from(data)
      ..sort((a, b) => b.date.compareTo(a.date));
    
    return sortedData
        .map((transaction) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TransactionItemCard(transaction: transaction),
            ))
        .toList();
  }

  Future<void> _showAddTransactionForm(BuildContext context) async {
    final transaction = await showModalBottomSheet<Transaction>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddTransactionForm(isIncome: _showIncome),
    );

    if (transaction != null) {
      _addTransaction(transaction);
    }
  }
}