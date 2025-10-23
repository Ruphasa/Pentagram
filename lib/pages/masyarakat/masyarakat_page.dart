import 'package:flutter/material.dart';
import 'package:pentagram/utils/app_colors.dart';
import 'package:pentagram/pages/masyarakat/tambah_warga_page.dart';
import 'package:pentagram/pages/masyarakat/tambah_keluarga_page.dart';
import 'package:pentagram/pages/masyarakat/tambah_rumah_page.dart';
import 'package:pentagram/pages/masyarakat/tabs/warga_tab.dart';
import 'package:pentagram/pages/masyarakat/tabs/keluarga_tab.dart';
import 'package:pentagram/pages/masyarakat/tabs/rumah_tab.dart';

class MasyarakatPage extends StatefulWidget {
  const MasyarakatPage({super.key});

  @override
  State<MasyarakatPage> createState() => _MasyarakatPageState();
}

class _MasyarakatPageState extends State<MasyarakatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Refresh FAB when tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onFabPressed() {
    switch (_tabController.index) {
      case 0: // Warga
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TambahWargaPage(),
          ),
        );
        break;
      case 1: // Keluarga
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TambahKeluargaPage(),
          ),
        );
        break;
      case 2: // Rumah
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TambahRumahPage(),
          ),
        );
        break;
    }
  }

  String _getFabLabel() {
    switch (_tabController.index) {
      case 0:
        return 'Tambah Warga';
      case 1:
        return 'Tambah Keluarga';
      case 2:
        return 'Tambah Rumah';
      default:
        return 'Tambah';
    }
  }

  IconData _getFabIcon() {
    switch (_tabController.index) {
      case 0:
        return Icons.person_add_rounded;
      case 1:
        return Icons.family_restroom_rounded;
      case 2:
        return Icons.home_rounded;
      default:
        return Icons.add_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 400;
    
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          title: const Text(
            'Data Masyarakat',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textOnPrimary,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.textOnPrimary,
            labelColor: AppColors.textOnPrimary,
            unselectedLabelColor: AppColors.textOnPrimary.withOpacity(0.7),
            tabs: const [
              Tab(text: 'Warga'),
              Tab(text: 'Keluarga'),
              Tab(text: 'Rumah'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            WargaTab(),
            KeluargaTab(),
            RumahTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _onFabPressed,
          backgroundColor: AppColors.primary,
          icon: Icon(
            _getFabIcon(),
            color: AppColors.textOnPrimary,
            size: isCompact ? 20 : 24,
          ),
          label: Text(
            _getFabLabel(),
            style: TextStyle(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w600,
              fontSize: isCompact ? 12 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
