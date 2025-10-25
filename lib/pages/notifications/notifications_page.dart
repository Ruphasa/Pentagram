import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/pages/pesan/pesan_warga_page.dart';
import 'package:pentagram/pages/log_aktivitas/log_aktivitas_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final GlobalKey _pesanKey = GlobalKey();
  final GlobalKey _logKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onFilterPressed() {
    if (_tabController.index == 0) {
      final state = _pesanKey.currentState;
      // ignore: avoid_dynamic_calls
      (state as dynamic).openFilter?.call();
    } else {
      final state = _logKey.currentState;
      // ignore: avoid_dynamic_calls
      (state as dynamic).openFilter?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        title: const Text('Notifikasi'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pesan'),
            Tab(text: 'Log Aktivitas'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: _onFilterPressed,
            tooltip: 'Filter',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PesanWargaPage(key: _pesanKey, embedded: true),
          LogAktivitasPage(key: _logKey, embedded: true),
        ],
      ),
    );
  }
}
